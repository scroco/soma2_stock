class DayCandle < ActiveRecord::Base
  attr_accessible :symbol, :date, :o, :h, :l, :c, :v, :trading_date

  def self.duplicated? symbol, date
    self.where(:symbol => symbol, :date => date).exists?
  end

  belongs_to :firm_daily_datum
  belongs_to :stock_code, :primary_key => :symbol, :foreign_key => :symbol

  def to_json
    [self.date, self.o, self.h, self.l, self.c]
  end

  def as_json options = {}
    [Time.parse(self.date).utc.to_i*1000, self.c]

  end
end
