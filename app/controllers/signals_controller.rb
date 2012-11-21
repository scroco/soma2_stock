class SignalsController < ApplicationController
  respond_to :json, :html

  def show

    @symbol = params[:id]
    stock_code = StockCode.where(:symbol => @symbol).first

    @signals = []
    stock_code.trading_signals.find_each do |signal|
      if signal.entry_date
        entry_date = signal.entry_date.utc.to_i * 1000
      end

      if signal.exit_date
        exit_date = signal.exit_date.utc.to_i * 1000
      end

      @signals.push({"entry_date" => entry_date, "exit_date" => exit_date, "trading_strategy_id" => signal.trading_strategy.id, "trading_strategy_name" => signal.trading_strategy.name})
    end

    respond_with(@signals)
  end
end
