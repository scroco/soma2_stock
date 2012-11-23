class StockCodesController < ApplicationController
  def index
    @stock_codes = StockCode.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stock_codes }
    end
  end

  def destroy_multiple
    if params[:stock_code_ids]
      @stock_codes = StockCode.find(params[:stock_code_ids])
      @stock_codes.each do |stock_code|
        stock_code.destroy
      end
    end

    respond_to do |format|
      format.json { head :no_content }
      format.html { redirect_to stock_codes_url }
    end
  end
end
