# coding: utf-8
require 'nokogiri'
require 'open-uri'
require 'tasks/code_crawler'
require 'app/models/stock_codes'

def crawl_all_chart
  #crawl_chart(code)
  #puts StockCodes.methods

  #puts (Time.now - 60*60*24).utc
  #StockCodes.find(:all, :conditions => ["crawl_date < '#{(Time.now - 60*60*24).utc}' OR crawl_date IS NULL"]).each do |stock_code|

  #StockCodes.find(:all).each do |stock_code|
  StockCodes.find(:all, :conditions => ["crawl_date IS NULL"]).each do |stock_code|
    crawl_chart(stock_code[:symbol])
    # 60*60*24 : 1 day


    # TODO : add timestamp of crawling and compare before crawling
    stock_code['crawl_date'] = Time.now

    #puts stock_code['id']
    #stock_code['crawl_date'] = nil
    stock_code.save

  end
end

def crawl_chart (code = 000270, count = 10000)
  puts "http://fchart.stock.naver.com/sise.nhn?symbol=#{code}&timeframe=day&count=#{count}&requestType=0"
  doc = Nokogiri::XML(
      open("http://fchart.stock.naver.com/sise.nhn?symbol=#{code}&timeframe=day&count=#{count}&requestType=0"), nil,
      'euc-kr')
  chartdata = doc.css("protocol chartdata")

  #chartdata[0].attributes.each do |key, value|
  puts "#{key}, #{value}"
  #end

  symbol = chartdata[0]["symbol"]

  items = chartdata.css("item")

  items.each do |item|
    date, o, h, l, c, v = item["data"].split("|")
    puts "#{symbol}, #{date}, #{o}, #{h}, #{l}, #{c}, #{v}"

    if !DayCandle.duplicated?(symbol, date)
      begin
        DayCandle.create(:symbol => symbol, :date => date, :o => o, :h => h, :l => l, :c => c, :v => v)
      rescue
        puts $!
      end
    else
      puts "Duplicated! #{symbol}, #{date}"
    end
  end
end