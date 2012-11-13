# coding: utf-8
require 'tasks/chart_crawler'
require 'tasks/code_crawler'
require 'tasks/firmdata_crawler'

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
end