class StockCode < ActiveRecord::Base
  attr_accessible :issue_code, :symbol, :name, :eng_name, :standard_code, :short_code, :market_type, :crawl_date

  def self.duplicated? symbol
    self.where(:symbol => symbol).exists?
  end

  has_many :day_candles, :primary_key => :symbol, :foreign_key => :symbol
  has_many :firm_data
  has_many :trading_signals
end