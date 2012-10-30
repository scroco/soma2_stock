class CreateDayCandles < ActiveRecord::Migration
  def change
    create_table :day_candles do |t|
      t.string :symbol
      t.string :date
      t.integer :o
      t.integer :h
      t.integer :l
      t.integer :c
      t.integer :v
      t.timestamps
    end
  end
end
