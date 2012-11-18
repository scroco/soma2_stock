class DayCandle < ActiveRecord::Base
  attr_accessible :symbol, :date, :o, :h, :l, :c, :v

  def self.duplicated? symbol, date
    self.where(:symbol => symbol, :date => date).exists?
  end

  belongs_to :stock_code, :primary_key => :symbol, :foreign_key => :symbol
end
