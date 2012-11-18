class FirmDailyDatum < ActiveRecord::Base
  attr_accessible :per, :pbr, :pcr, :pdr, :psr, :market_capitalization, :iroi

  has_one :day_candle
end
