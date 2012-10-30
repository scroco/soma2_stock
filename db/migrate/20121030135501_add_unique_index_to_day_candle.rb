class AddUniqueIndexToDayCandle < ActiveRecord::Migration
  def change
    add_index :day_candles, [:date, :symbol], :unique => true
  end
end
