class AddIndexToAssociationOfOrders < ActiveRecord::Migration
  def change
    add_index :orders, [:trading_signal_id]
    add_index :orders, [:asset_account_id]
    add_index :orders, [:entry_day_candle_id]
    add_index :orders, [:exit_day_candle_id]
  end
end
