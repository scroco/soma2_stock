class DayCandle < ActiveRecord::Base
  attr_accessible :symbol, :date, :o, :h, :l, :c, :v

  def self.duplicated? symbol, date
    self.where(:symbol => symbol, :date => date).exists?
  end
end
