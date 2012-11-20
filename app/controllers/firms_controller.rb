class FirmsController < ApplicationController
  def index
    @symbol = params[:id]

  end
  def show
    @symbol = params[:id]
    stock_code = StockCode.where(:symbol => params[:id]).first
    @stock_code = stock_code

  end
end
