class TradingSignal < ActiveRecord::Base
  attr_accessible :entry_date, :exit_date
  # :entry_date, :exit_date 로 parameter 찾을 수 있음
  # TODO : => association 걸기로 바꾸기

  def get_entry_day_candle
    day_candle = self.stock_code.day_candles.where(:date => :entry_date).first
  end

  def get_exit_day_candle
    day_candle = self.stock_code.day_candles.where(:date => :exit_date).first
  end

  def get_entry_firm_datum

  end

  def get_exit_firm_datum

  end

  belongs_to :trading_strategy
  belongs_to :stock_code
  has_many :orders
end

