# coding: utf-8
require 'tasks/chart_crawler'
require 'tasks/code_crawler'
require 'tasks/firmdata_crawler'
require 'tasks/firm_data_calculator'

namespace :crawler do
  task :day_candle => :environment do
    #crawl_chart
    puts "crawl_all_chart started"
    crawl_all_chart
  end

  task :stock_codes => :environment do
    crawl_code
  end

  task :firm_data => :environment do
    #crwal_financialStatement
    crawl_firmdata
  end

  task :firm_data_calculator2 => :environment do
    puts "firm_data_calculator started"
    firm_data_calculator
  end

  task :firm_data_calculator => :environment do
    puts "firm_data_calculator started"
    #firm_data_calculator

    pool_size = 5
    calculator = FirmDataCalculator.pool(:size => pool_size)
    calculators = []

    DayCandle.where("firm_daily_datum_id is null and trading_date >= ?", Time.utc(2002,12,31)).find_in_batches(:batch_size => 100) do |candles|
      begin
        calculators << calculator.future(:execute, candles)

        if(calculators.size % pool_size == 0)
          calculators.compact.each{|v| v.value}
          calculators = []
        end
      rescue => ex
        puts ex
      end
    end

    if(calculators.size > 0)
      calculators.compact.each{|v| v.value}
    end

    while(true) do
      sleep(1)
    end
  end
end

namespace :back_tester do
  task :signal => :environment do
    TradingStrategy.determine_signal_start
  end

  task :asset => :environment do
    AssetAccount.start_simulation
  end

  task :generate_strategies => :environment do
    ts = TradingStrategy.where(:name => "First Trading Strategy").first
    if ts == nil
      ts = TradingStrategy.new(:name => "First Trading Strategy")
    end

    source = <<-eos

    # 이익 예측가능성
    # 매출
    firm_data = stock_code.firm_data.where("date < ?", date)
    last_firm_data = firm_data.last

    if firm_data and last_firm_data
      pass_count = 0

      recent_firm_data = firm_data.where("date >= ?", date - 1.years).order(:date)

      # 매출액 테스트
      if last_firm_data.sales and last_firm_data.sales >= 3400
        pass_count += 1
      end

      # 유동비율 : 유동자산 / 유동부채 * 100 (working_capital / floating_debt)
      if last_firm_data.working_capital and last_firm_data.floating_debt
        current_ratio = last_firm_data.working_capital / last_firm_data.floating_debt * 100
        if current_ratio >= 200
          pass_count += 1
        end
      end

      # 장기 EPS 성장 (과거 1년간)
      # 1년 전 꺼 랑 지금꺼랑 30% 이상
      # 지금 / 1년전 * 100 > 130 and 1년꺼 평균 > 0


      sum_of_eps = 0
      count_of_eps = 0
      recent_firm_data.find_each do |firm_datum|
        if firm_datum.eps
          sum_of_eps += firm_datum.eps
          count_of_eps += 1
        end
      end

      if count_of_eps > 0 and sum_of_eps >= 0
        if recent_firm_data.first.eps and recent_firm_data.last.eps and
            recent_firm_data.first.eps * 1.3 <= recent_firm_data.last.eps
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
    eos


    ts.strategy = source
    ts.save

    ts.save

    as = AssetStrategy.where(:name => "First Asset Strategy").first
    if as == nil
      as = AssetStrategy.new(:name => "First Asset Strategy")
    end
    as.save

    aa = AssetAccount.new(:base_asset => 2000000)
    ts.asset_accounts << aa
    as.asset_accounts << aa
    aa.save
  end
end
