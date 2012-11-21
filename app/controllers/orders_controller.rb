class OrdersController < ApplicationController
  respond_to :json, :html

  def index
    #@orders = Order.all
    @orders = []
    Order.find_each do |order|
      signal = order.trading_signal
      stock_code = signal.stock_code
      stock_code_name = stock_code.name
      stock_code_symbol = stock_code.symbol

      entry_day_candle = order.entry_day_candle
      exit_day_candle = order.exit_day_candle

      @orders.push({"asset_strategy_name" => order.asset_account.asset_strategy.name, "stock_code_name" => stock_code_name, "stock_code_symbol" => stock_code_symbol,
                   "entry_date" => entry_day_candle.date, "exit_date" => exit_day_candle.date,
                   "entry_market_price" => entry_day_candle.o, "exit_market_price" => exit_day_candle.o})
    end

    respond_with(@orders)
  end

  def show
    @orders = []
    asset_account_id = params[:id]
    AssetAccount.find(asset_account_id).orders.find_each do |order|
      signal = order.trading_signal
      stock_code = signal.stock_code
      stock_code_name = stock_code.name
      stock_code_symbol = stock_code.symbol

      entry_day_candle = order.entry_day_candle
      exit_day_candle = order.exit_day_candle

      @orders.push({"asset_strategy_name" => order.asset_account.asset_strategy.name, "stock_code_name" => stock_code_name, "stock_code_symbol" => stock_code_symbol,
                    "entry_date" => entry_day_candle.date, "exit_date" => exit_day_candle.date,
                    "entry_market_price" => entry_day_candle.o, "exit_market_price" => exit_day_candle.o})
    end

    respond_with(@orders)

  end
end
