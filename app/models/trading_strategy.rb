class TradingStrategy < ActiveRecord::Base
  attr_accessible :name, :strategy, :start_date, :end_date
  #2003년 1월 1일 ~ 오늘까지

  def is_parameter_pass? (date, stock_code)
    #:entry_parameter, :exit_paramenter
    is_pass = false

    # 이익 예측가능성

    # 매출
    firm_data = stock_code.firm_data.where("date < ?", date)
    last_firm_data = firm_data.last

    if firm_data and last_firm_data
      pass_count = 0
      #puts "date : #{date}"

      recent_firm_data = firm_data.where("date >= ?", date - 1.years).order(:date)

      # 매출액 테스트
      if last_firm_data[:sales] and last_firm_data[:sales] >= 3400
        pass_count += 1
      end

      # 유동비율 : 유동자산 / 유동부채 * 100 (working_capital / floating_debt)
      if last_firm_data[:working_capital] and last_firm_data[:floating_debt]
        current_ratio = last_firm_data[:working_capital] / last_firm_data[:floating_debt] * 100
        if current_ratio >= 200
          pass_count += 1
        end
      end

      # 장기 EPS 성장 (과거 1년간)
      # 1년 전 꺼 랑 지금꺼랑 30% 이상
      # 지금 / 1년전 * 100 > 130 and 1년꺼 평균 > 0


      sum_of_eps = 0
      count_of_eps = 0
      recent_firm_data.each do |firm_datum|
        if firm_datum[:eps]
          sum_of_eps += firm_datum[:eps]
          count_of_eps += 1
        end
      end

      if count_of_eps > 0 and sum_of_eps >= 0
        if recent_firm_data.first[:eps] and recent_firm_data.last[:eps] and
            recent_firm_data.first[:eps] * 1.3 <= recent_firm_data.last[:eps]
          pass_count += 1
        end
      end

      # FirmDailyDatum
      # attr_accessible :per, :pbr, :pcr, :pdr, :psr, :market_capitalization, :iroi

      if last_firm_data[:per] and last_firm_data[:per] <= 15
        pass_count += 1
      end

      if last_firm_data[:pbr] and last_firm_data[:per] and last_firm_data[:pbr] * last_firm_data[:per] <= 22
        pass_count += 1
      end

      # 총부채비율 100% 이하
      #debt_to_equity_ratio
      if last_firm_data[:debt_to_equity_ratio] and last_firm_data[:debt_to_equity_ratio] <= 230
        pass_count += 1
      end


      is_pass = (pass_count > 2)
    end


    return is_pass
  end

  # 특정한 날짜에 특정한 종목에 대한 테스트
  def determine_signal_on_date_in_stock (date, stock_code)
    is_pass = is_parameter_pass? date, stock_code

    last_signal = stock_code.trading_signals.where("entry_date < ?", date).last

    if last_signal and !last_signal[:exit_date]
      # 바로 앞의 signal 은 entry 상태

      # entry => 통과 : none
      # entry => 실패 : exit
      if !is_pass
        puts "exit"
        last_signal[:exit_date] = date
        last_signal.save
        # TODO : parameter 저장하면 좋겠음.
      end
    else
      # 열린 Signal이 없는 상태
      # exit => 통과 : entry
      # exit => 실패 : none
      if is_pass
        if last_signal and last_signal[:entry_date] > date - 2.days
          puts "entry with recent"
          last_signal[:exit_date] = nil
          last_signal.save
        else
          trading_signal = TradingSignal.new(:entry_date => date)
          # TODO : parameter 저장하면 좋겠음.

          puts "entry"
          stock_code.trading_signals << trading_signal
          self.trading_signals << trading_signal
          trading_signal.save
        end

      end
    end
  end

  # 테스터가 실행하며, signal들을 찾아준다.
  # start function
  def determine_signal
    # 테스트 된 날짜부터 목표날짜까지 테스트
    target_date = Time.now
    start_date = self[:end_date]
    start_date = Time.parse("030101")
    if start_date == nil
      start_date = Time.parse("030101")
    end

    (start_date.to_date..target_date.to_date).each do |date|
      #formatted_date = date.strftime("%Y%m%d")

      # 모든 종목에 대해서 테스트
      StockCode.find_each do |stock_code|
        determine_signal_on_date_in_stock date, stock_code
      end

      # 똑같은 날짜는 다시 테스트 안하게
      puts "date : #{date}"
      self[:end_date] = date
      self.save
    end
  end

  # 테스터
  # start function
  def self.determine_signal_start
    TradingStrategy.find_each do |trading_strategy|
      puts "name : #{trading_strategy[:id]}"
      trading_strategy.determine_signal
    end
  end

  has_many :trading_signals
  #has_many :asset_managers
end
