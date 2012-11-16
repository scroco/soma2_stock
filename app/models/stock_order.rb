class StockOrder < ActiveRecord::Base
   attr_accessible :trading_strategy_id, :stock_code_id, :type, :date
end
