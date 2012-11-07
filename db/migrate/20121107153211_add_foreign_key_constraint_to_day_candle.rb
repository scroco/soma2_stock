class AddForeignKeyConstraintToDayCandle < ActiveRecord::Migration
  def change
    add_foreign_key :day_candles, :stock_codes, {column: :symbol, primary_key: :symbol}
  end
end
