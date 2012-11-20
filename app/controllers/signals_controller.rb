class SignalsController < ApplicationController
  respond_to :json, :html

  def index
    @signals = TradingSignal.all

    respond_with(@signals, :only => [:exit_date])
  end
end
