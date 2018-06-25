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
     c = Currency.find_by_code(currency.to_s)
     if withdraw.currency == 'eth'
       balance = open(c.rpc + '/cgi-bin/total.cgi').read.rstrip.to_f
       raise Account::BalanceError, 'Insufficient coins' if balance < withdraw.sum
       fee = [withdraw.fee.to_f || withdraw.channel.try(:fee) || 0.0005, 0.1].min
       CoinRPC[withdraw.currency].personal_unlockAccount(c.main_address, "", 36000)
       txid = CoinRPC[withdraw.currency].eth_sendTransaction(from: c.main_address ,to: withdraw.fund_uid, value: '0x ' +((withdraw.amount.to_f ).to_i.to_s(16)))
     else
       balance = CoinRPC[withdraw.currency].getbalance.to_d
       raise Account::BalanceError, 'Insufficient coins' if balance < withdraw.sum
       fee = [withdraw.fee.to_f || withdraw.channel.try(:fee) || 0.0005, 0.1].min
       CoinRPC[withdraw.currency].settxfee fee
       txid = CoinRPC[withdraw.currency].sendtoaddress withdraw.fund_uid, withdraw.amount.to_f
     end
     withdraw.whodunnit('Worker::WithdrawCoin') do
       withdraw.update_column :txid, txid
       # withdraw.succeed! will start another transaction, cause
       # Account after_commit callbacks not to fire
       withdraw.succeed
       withdraw.save!
     end
   end

  sleep 1.hour
end
