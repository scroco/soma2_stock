class DayCandle < ActiveRecord::Base
  attr_accessible :symbol, :date, :o, :h, :l, :c, :v

  def self.duplicated? symbol, date
    self.where(:symbol => symbol, :date => date).exists?
  end

  has_many :stock_codes, :primary_key => :symbol, :foreign_key => :symbol
end
