class AssetAccount < ActiveRecord::Base
  attr_accessible :base_asset, :current_asset, :start_date, :end_date, :constant_asset

  def do_ordering
    # 날짜가 정해지지 않았다면 투자전략의 날짜를 따른다.
    # 저장을 하지 않는 이유는 시뮬레이션 할때마다 바뀌는 날짜를 반영하기 위해서
    start_date = self[:start_date]
    end_date = self[:end_date]

    if start_date == nil
      start_date = self.trading_strategy[:start_date]
      if start_date == nil
        start_date = Time.parse("030101")
      end
    end
    if end_date == nil
      end_date = self.trading_strategy[:end_date]
      if end_date == nil
        end_date = Time.now
      end
    end


    # TODO : account에 맞는 전략의 signal을 기반으로 order 생성
    trading_signals = self.trading_strategy.trading_signals

    # 기간에 맞는 signal들만 고름
    trading_signals = trading_signals.where("entry_date >= ?", start_date).where("entry_date <= ?", end_date)

    prev_date = nil
    same_date_signals = Array.new
    trading_signals.order("entry_date").find_each do |trading_signal|
      # 각각의 trading_signal 테스트

      # 같은 signal끼리 모아서 처리
      if prev_date and prev_date < trading_signal[:entry_date]
        # 모인 signals 에 대해서 처리

        # signals를 기반으로 asset_strategy에서 투자금액을 얻어옴
        investment_asset = self.asset_strategy.investment_asset({:constant_asset => self[:constant_asset],
                                                                 :same_date_signals => same_date_signals})

        # iterating 하면서 투자금액을 기반으로 주식수 계산 (다음날 시가 기준)
        same_date_signals.each do |signal|
          # Order 생성

          # asset account에 관련된 order 중에서 signal도 현재 signal과 연결된 것
          # account vs order : 1:n
          # signal vs order : 1:n
          o = self.orders.where(:trading_signal_id => signal.id).first
          if o == nil
            o = Order.new
          end
          o.trading_signal = signal
          self.orders << o

          # entry 설정
          #puts "entry"
          entry_day_candle = signal.stock_code.day_candles.where(:trading_date => signal[:entry_date] + 1.days).first
          if entry_day_candle
            market_price = entry_day_candle[:o]
            market_volume = entry_day_candle[:v]
            number_of_stocks =  (investment_asset / market_price).round

            # 거래량의 10%까지만 거래가 성립한다고 본다.
            if number_of_stocks > market_volume * 0.1
              number_of_stocks = market_volume * 0.1
            end

            o.number_of_stocks = number_of_stocks
            o.entry_day_candle = entry_day_candle
          end

          # exit 설정
          exit_date = signal[:exit_date]
          if exit_date == nil or exit_date > end_date
            # exit_date가 정해진 exit_date보다 뒤쪽일 경우 end_date에 파는 것으로 한다.
            exit_date = end_date - 1
          end
          #puts "exit"
          exit_day_candle = signal.stock_code.day_candles.where("trading_date > ?", exit_date).order("trading_date").first

          if exit_day_candle
            o.exit_day_candle = exit_day_candle
          end

          #puts "update"
          # update order
          o.save
        end

        same_date_signals.clear
      end

      prev_date = trading_signal[:entry_date]
      same_date_signals.push(trading_signal)
    end
  end

  def do_simulation

    # association 잘 되어있는지 테스트
    if self.trading_strategy == nil or self.asset_strategy == nil
      puts "AssetAccount Error : must have trading_strategy and asset_strategy"
      return
    end

    # signal 기반으로 order를 낸다.
    do_ordering

    # order를 기반으로 수익률을 계산한다.
    sum_of_earning = 0
    self.orders.find_each do |order|
      if order.entry_day_candle and order.entry_day_candle and order.number_of_stocks
        # 데이터가 있는것에서만 수익률 계산 가능
        buy_market_price = order.entry_day_candle.o
        sell_market_price = order.exit_day_candle.o
        volume = order.number_of_stocks
        #puts buy_market_price
        #puts sell_market_price
        earning = volume * (sell_market_price - buy_market_price)

        # 슬리피지 적용
        # TODO : earning에? 혹은 sell_market_price에?
        earning *= 0.99
        sum_of_earning += earning
      end
    end

    # 수익량 출력
    puts sum_of_earning
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
