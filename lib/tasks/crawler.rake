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