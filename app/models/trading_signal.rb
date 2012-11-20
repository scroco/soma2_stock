class TradingSignal < ActiveRecord::Base
  attr_accessible :entry_date, :exit_date

  belongs_to :trading_strategy
  belongs_to :stock_code
  has_many :orders
end

