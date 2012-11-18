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