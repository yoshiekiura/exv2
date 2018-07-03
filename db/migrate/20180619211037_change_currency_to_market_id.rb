class ChangeCurrencyToMarketId < ActiveRecord::Migration
  def change
    change_column :orders, :currency, :string, limit: 10
    rename_column :orders, :currency, :market_id
    
    change_column :trades, :currency, :string, limit: 10
    rename_column :trades, :currency, :market_id
  end
end
