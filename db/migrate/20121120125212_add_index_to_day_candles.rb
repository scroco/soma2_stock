class AddIndexToDayCandles < ActiveRecord::Migration
  def change
    add_index :day_candles, [:trading_date]
  end
end
