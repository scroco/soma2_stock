class StockCode < ActiveRecord::Base
  attr_accessible :issue_code, :symbol, :name, :eng_name, :standard_code, :short_code, :market_type, :crawl_date

  def self.duplicated? symbol
    self.where(:symbol => symbol).exists?
  end

  belongs_to :day_candle, :primary_key => :symbol, :foreign_key => :symbol
end
