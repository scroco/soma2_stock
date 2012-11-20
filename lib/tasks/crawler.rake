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

  task :firm_data_calculator => :environment do
    puts "firm_data_calculator started"
    firm_data_calculator
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