class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :number_of_stocks
      t.integer :trading_signal_id
      t.integer :asset_account_id
      t.integer :entry_day_candle_id
      t.integer :exit_day_candle_id

      t.timestamps
    end
  end
end
