class AssetAccount < ActiveRecord::Base
  attr_accessible :base_asset, :current_asset, :start_date, :end_date, :constant_asset

  def do_ordering
    # 날짜가 정해지지 않았다면 투자전략의 날짜를 따른다.
    # 저장을 하지 않는 이유는 시뮬레이션 할때마다 바뀌는 날짜를 반영하기 위해서
    start_date = self.start_date
    end_date = self.end_date

    if start_date == nil
      start_date = self.trading_strategy.start_date
      if start_date == nil
        start_date = Time.parse("030101")
      end
    end
    if end_date == nil
      end_date = self.trading_strategy.end_date
      if end_date == nil
        end_date = Time.now
      end
    end


    # TODO : account에 맞는 전략의 signal을 기반으로 order 생성

    # 기간에 맞는 signal들만 고름
    trading_signals = self.trading_strategy.trading_signals.where("entry_date >= ?", start_date).where("entry_date <= ?", end_date)

    prev_date = nil


    all_dates = []
    trading_signals.find_each do |trading_signal|
      all_dates.push(trading_signal.entry_date)
      all_dates.push(trading_signal.exit_date)
    end
    all_dates.uniq!
    #puts all_dates
    #all_dates = all_dates.sort  {|a,b| a <=> b}

    # 각 날짜별로 돌면서 테스트
    all_dates.each do |date|
      # 만약 테스트 해야하는 날짜를 벗어나면 종요한다.
      if date == nil or date > end_date
        break
      end

      # entry 처리
      # 시그널중에 그 날짜에 해당하는 entry 시그널들을 가지고 온다.
      entry_signals = trading_signals.where(:entry_date => date).all
      if entry_signals
        # signals를 기반으로 asset_strategy에서 투자금액을 얻어옴
        investment_asset = self.asset_strategy.investment_asset(:constant_asset => self.constant_asset,
                                                                :same_date_signals => entry_signals)

        # iterating 하면서 투자금액을 기반으로 주식수 계산 (다음날 시가 기준)
        entry_signals.each do |signal|
          entry_day_candle = signal.stock_code.day_candles.where(:trading_date => signal.entry_date + 1.days).first
          if entry_day_candle
            buy_market_price = entry_day_candle.o
            market_volume = entry_day_candle.v
            number_of_stocks =  (investment_asset / buy_market_price).round

            # 거래량의 10%까지만 거래가 성립한다고 본다.
            if number_of_stocks > market_volume * 0.1
              number_of_stocks = market_volume * 0.1
            end

            # 실제 투자 처리
            buy_market_asset =  buy_market_price * number_of_stocks
            if self.current_asset >= buy_market_asset
              self.current_asset -= buy_market_asset
              # Order 생성
              order = self.orders.where(:trading_signal_id => signal.id).first
              if order == nil
                order = Order.new
              end
              order.trading_signal = signal
              self.orders << order

              order.number_of_stocks = number_of_stocks
              order.entry_day_candle = entry_day_candle
              order.exit_day_candle = nil
              self.save
              order.save
            end
          end
        end
      end

      #exit 처리
      exit_signals = trading_signals.where(:exit_date => date).all
      if exit_signals
        exit_signals.each do |signal|
          # exit 날짜 정하기
          exit_date = signal.exit_date
          if exit_date == nil or exit_date > end_date
            # exit_date가 정해진 exit_date보다 뒤쪽일 경우 end_date에 파는 것으로 한다.
            exit_date = end_date - 1.days
          end

          # 현재 signal에 해당하는 order들을 가지고 온다.
          signal.orders.find_each do |order|
            #exit_day_candle = signal.stock_code.day_candles.where("trading_date > ?", exit_date).order("trading_date").first
            exit_day_candle = signal.stock_code.day_candles.where(:trading_date => exit_date + 1.days).first
            if exit_day_candle
              sell_market_asset = order.number_of_stocks * exit_day_candle.o
              order.exit_day_candle = exit_day_candle
              self.current_asset += sell_market_asset
              order.save
            end
          end
        end
      end

    end

    # exit 날짜가 정해지지 않은 것은 가장 마지막 날짜 day_candle로 정한다.
    self.orders.where(:exit_day_candle_id => nil).find_each do |order|
      last_day_candle = order.trading_signal.stock_code.day_candles.last
      order.exit_day_candle = last_day_candle
      order.save
    end


  end

  def do_simulation

    # association 잘 되어있는지 테스트
    if self.trading_strategy == nil or self.asset_strategy == nil
      puts "AssetAccount Error : must have trading_strategy and asset_strategy"
      return
    end

    # 자본금 설정
    self.current_asset = self.base_asset
    self.save

    # signal 기반으로 order를 낸다.
    do_ordering

    # order를 기반으로 수익률을 계산한다.
    sum_of_earning = 0
    self.orders.find_each do |order|

      if order.entry_day_candle and order.entry_day_candle and order.number_of_stocks
        # 데이터가 있는것에서만 수익률 계산 가능
        buy_market_price = order.entry_day_candle.o
        sell_market_price = 0
        if order.exit_day_candle == nil
          #sell_market_price = last_day_candle.o
          sell_market_price = 0
        else
          sell_market_price = order.exit_day_candle.o
        end

        volume = order.number_of_stocks
        #puts buy_market_price
        #puts sell_market_price
        earning = volume * (sell_market_price - buy_market_price)

        # 슬리피지 적용
        # TODO : earning에? 혹은 sell_market_price에?
        #earning *= 0.99
        sum_of_earning += earning
      end
    end

    # 수익량 출력
    puts sum_of_earning
    #self.current_asset = self.base_asset + sum_of_earning.to_int
    #self.save
  end

  def self.start_simulation
    AssetAccount.find_each do |asset_account|
      asset_account.do_simulation
    end
  end

  belongs_to  :trading_strategy
  belongs_to  :asset_strategy
  has_many    :orders
end
