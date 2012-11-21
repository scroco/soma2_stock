class FirmsController < ApplicationController
  def index
    @symbol = params[:id]

  end
  def show
    @symbol = params[:id]
    stock_code = StockCode.where(:symbol => @symbol).first
    @stock_code = stock_code
    @firm_data = stock_code.firm_data.order("date DESC").first

  end
end
