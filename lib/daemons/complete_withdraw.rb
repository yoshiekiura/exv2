#!/usr/bin/env ruby

# You might want to change this
ENV["RAILS_ENV"] ||= "development"

root = File.expand_path(File.dirname(__FILE__))
root = File.dirname(root) until File.exists?(File.join(root, 'config'))
Dir.chdir(root)

require File.join(root, "config", "environment")

$running = true
Signal.trap("TERM") do 
  $running = false
end

while($running) do
   Withdraw.lock.almost_done.each do |withdraw|
   	c = Currency.find_by_code(withdraw.currency.to_s)
   	next unless withdraw.currency == 'btc'
    balance = CoinRPC[withdraw.currency].getbalance.to_d
    if balance < withdraw.sum
    	puts "Insufficient coins"
    	next
    end
    fee = [withdraw.fee.to_f || withdraw.channel.try(:fee) || 0.0005, 0.1].min
    CoinRPC[withdraw.currency].settxfee fee
    begin    
      txid = CoinRPC[withdraw.currency].sendtoaddress withdraw.fund_uid, withdraw.amount.truncate(5).to_f 
      withdraw.whodunnit('Worker::WithdrawCoin') do
        withdraw.update_column :txid, txid
        # withdraw.succeed! will start another transaction, cause
        # Account after_commit callbacks not to fire
        withdraw.succeed
        withdraw.save!
      end
    rescue Exception => e 
      puts "Withdraw failed error: #{e}"  	
    end
   end

  sleep 1.hour
end
