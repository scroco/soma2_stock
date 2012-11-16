class WarrenBuffett

  def strategy
    @strategy
  end

  def init
    strategy = TradingStrategy.where(:name => "Warren Buffett")
    if strategy == nil then
      strategy = TradingStrategy.Create(:name => "Warren Buffett")
    end

  end

end