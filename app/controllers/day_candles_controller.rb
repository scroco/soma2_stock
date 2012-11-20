class DayCandlesController < ApplicationController
  respond_to :json
  def show

    @day_candle = DayCandle.where(:symbol => params[:id])

    #respond_with(@day_candle)

    respond_to do |wants|
      wants.json{
        render :json => @day_candle.to_json
      }
    end
  end

end
