class DayCandle < ActiveRecord::Base
  attr_accessible :symbol, :date, :o, :h, :l, :c, :v

  def self.duplicated? symbol, date
    self.where(:symbol => symbol, :date => date).exists?
  end

<<<<<<< HEAD
  belongs_to :firm_daily_data
  belongs_to :stock_codes, :primary_key => :symbol, :foreign_key => :symbol
=======
  belongs_to :stock_code, :primary_key => :symbol, :foreign_key => :symbol
>>>>>>> 0715497cd2aef819935cffbd09684404f5d750bc
end
