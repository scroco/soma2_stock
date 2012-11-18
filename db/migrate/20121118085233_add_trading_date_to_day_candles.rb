class AddTradingDateToDayCandles < ActiveRecord::Migration
  def up
    add_column('day_candles', 'trading_date', :datetime)
    add_index :day_candles, [:trading_date, :symbol], :unique => true

    # update trading_date
    DayCandle.find_each do |day_candle|
      date = day_candle[:date]
      trading_date = Time.parse(date)
      day_candle[:trading_date] = trading_date
      day_candle.save
    end
  end
  def down
    remove_index :day_candles, [:trading_date, :symbol]
    remove_column('day_candles', 'trading_date')
  end

end
