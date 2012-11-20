class Order < ActiveRecord::Base
  attr_accessible :number_of_stocks

  belongs_to :trading_signal
  belongs_to :asset_account
  belongs_to :entry_day_candle, :class_name => DayCandle
  belongs_to :exit_day_candle, :class_name => DayCandle
end
