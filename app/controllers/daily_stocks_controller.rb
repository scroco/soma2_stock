class DailyStocksController < ApplicationController
  respond_to :json
  def show

    day_candles = DayCandle.where(:symbol => params[:id])

    #respond_with(@day_candle)

    @daily_stocks = []
    day_candles.find_each do |day_candle|

      @daily_stocks.push([Time.parse(day_candle.date).utc.to_i*1000, day_candle.c])
    end
    respond_with(@daily_stocks)


  end
end
