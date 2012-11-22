class StockCodesController < ApplicationController
  def index
    @stock_codes = StockCode.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stock_codes }
    end
  end
end
