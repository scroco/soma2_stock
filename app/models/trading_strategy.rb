class TradingStrategy < ActiveRecord::Base
  attr_accessible :name, :strategy, :start_date, :end_date
  #2003년 1월 1일 ~ 오늘까지

  def is_parameter_pass? (date, stock_code)
    #:entry_parameter, :exit_paramenter

    if self[:name] == "John Neff" then

    end

    # 각 전략별로 다르다.
    #if self[:name] == "워렌버핏"
    #  # 날짜에 해당하는 회사데이터, 일봉 데이터 얻어오기
    #  # 조건 판단
    #  #PER > 5
    #  # 통과 / 실패 판단
    #
    #  #:roe
    #end
    return true
  end

  # 특정한 날짜에 특정한 종목에 대한 테스트
  def determine_signal_on_date_in_stock (date, stock_code)
    is_pass = is_parameter_pass? date, stock_code
    last_signal = self.trading_signals.last
    if last_signal[:exit_date] == nil
      # 바로 앞의 signal 은 entry 상태

      # entry => 통과 : none
      # entry => 실패 : exit
      if ! is_pass
        last_signal[:exit_date] = date
        # TODO : parameter 저장하면 좋겠음.
      end
    else

      # 열린 Signal이 없는 상태
      # exit => 통과 : entry
      # exit => 실패 : none
      if is_pass
        trading_signal = TradingSignal.new(:entry_date => date)
        # TODO : parameter 저장하면 좋겠음.

        stock_code.trading_signals << trading_signal
        self.trading_signals << trading_signal
        trading_signal.save
      end
    end
  end

  # 테스터가 실행하며, signal들을 찾아준다.
  # start function
  def determine_signal()
    # 테스트 된 날짜부터 목표날짜까지 테스트
    target_date = Date.now

    ([:last_tested]..target_date).each do |date|
      formatted_date = date.strftime("%Y%m%d")

      # 모든 종목에 대해서 테스트
      StockCode.find_each do |stock_code|
        determine_signal_on_date_in_stock formatted_date, stock_code
      end
    end
  end

  has_many :trading_signals
  #has_many :asset_managers
end
