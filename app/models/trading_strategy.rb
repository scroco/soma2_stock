class TradingStrategy < ActiveRecord::Base
  attr_accessible :name

  def buy(stock_code, date)
    self.StockOrder.Create(:stock_code_id => stock_code, :type=> 'buy', :date => date)
  end

  def sell(stock_code, date)
    self.StockOrder.Create(:stock_code_id => stock_code, :type => 'sell', :date => date)
  end

  has_many :stock_orders

end
