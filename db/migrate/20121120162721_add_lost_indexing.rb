class AddLostIndexing < ActiveRecord::Migration
  def change
    add_index :day_candles, [:firm_daily_datum_id]
    add_index :firm_data, [:stock_code_id]
  end
end
