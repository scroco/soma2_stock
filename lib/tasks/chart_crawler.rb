# coding: utf-8
require 'nokogiri'
require 'open-uri'
require 'tasks/code_crawler'

def crawl_all_chart

  # 하루가 지난 데이터는 필요한 양만큼 새로 받음
  StockCode.where("crawl_date < ?", Time.now - 1.days).all.each do |stock_code|
    term_secs = Time.now - stock_code['crawl_date'];
    term_days = (term_secs / 1.days).round + 1
    crawl_chart(stock_code[:symbol], term_days)

    stock_code['crawl_date'] = Time.now
    stock_code.save
  end

  # 처음 시작할 때는 모든 데이터를 모음
  StockCode.where("crawl_date IS NULL").all.each do |stock_code|
  #StockCode.find(:all, :conditions => ["crawl_date IS NULL"]).each do |stock_code|
    crawl_chart(stock_code[:symbol])

    stock_code['crawl_date'] = Time.now
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
  #puts "#{key}, #{value}"
  #end

  if chartdata[0]
    symbol = chartdata[0]["symbol"]
  end

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