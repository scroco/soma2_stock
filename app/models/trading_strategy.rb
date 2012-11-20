# coding: utf-8

class TradingStrategy < ActiveRecord::Base
  attr_accessible :name, :strategy, :start_date, :end_date, :tested_date
  #2003년 1월 1일 ~ 오늘까지

  def is_parameter_pass? (date, stock_code)
    #:entry_parameter, :exit_paramenter
    is_pass = false

    eval(self.strategy)
    return is_pass
  end

  # 특정한 날짜에 특정한 종목에 대한 테스트
  def determine_signal_on_date_in_stock (date, stock_code)
    is_pass = is_parameter_pass? date, stock_code

    last_signal = stock_code.trading_signals.where("entry_date < ?", date).where(:trading_strategy_id => self.id).last

    if last_signal and !last_signal[:exit_date]
      # 바로 앞의 signal 은 entry 상태

      # entry => 통과 : none
      # entry => 실패 : exit
      if !is_pass
        puts "exit"
        last_signal.exit_date = date
        puts "last_signal[:exit_date] : #{last_signal[:exit_date]}"
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
          last_signal.exit_date = nil
          last_signal.save
        else
          trading_signal = TradingSignal.new(:entry_date => date)
          puts "trading_signal[:entry_date] : #{trading_signal[:entry_date]}"

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
    self[:start_date] = Time.parse("030101")
    self.save

    target_date = self[:end_date]
    if target_date == nil
      target_date = Time.now
    end
    tested_date = self[:tested_date]
    if tested_date == nil
      tested_date = self[:start_date]

      if tested_date == nil
        tested_date = Time.parse("030101")
      end
    end

    (tested_date.to_date..target_date.to_date).each do |date|
      #formatted_date = date.strftime("%Y%m%d")

      # 모든 종목에 대해서 테스트
      StockCode.find_each(:include => :trading_signals) do |stock_code|
        determine_signal_on_date_in_stock date, stock_code
      end

      # 똑같은 날짜는 다시 테스트 안하게
      puts "test ended date : #{date}"
      self[:tested_date] = date
      self.save
    end
  end

  # 테스터
  # start function
  def self.determine_signal_start
    TradingStrategy.find_each do |trading_strategy|
      puts "TradingStrategy name : #{trading_strategy[:id]}"
      trading_strategy.determine_signal
    end
  end

  has_many :trading_signals
  has_many :asset_accounts
end
