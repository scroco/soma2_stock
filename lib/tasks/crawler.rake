# coding: utf-8
require 'nokogiri'
require 'open-uri'

namespace :crawler do
  task :day_candle => :environment do
    doc = Nokogiri::XML(
        open("http://fchart.stock.naver.com/sise.nhn?symbol=000270&timeframe=day&count=10000&requestType=0"), nil,
        'euc-kr')

    chartdata = doc.css("protocol chartdata")

    #chartdata[0].attributes.each do |key, value|
    #  puts "#{key}, #{value}"
    #end

    symbol =chartdata[0]["symbol"]

    items = chartdata.css("item")

    items.each do |item|
      date, o, h, l, c, v = item["data"].split("|")
      puts "#{date}, #{o}, #{h}, #{l}, #{c}, #{v}"

      #if !DayCandle.duplicated?(symbol, date)
      begin
        DayCandle.create(:symbol => symbol, :date => date, :o => o, :h => h, :l => l, :c => c, :v => v)
      rescue
        puts $!
      end
      #else
      #  puts "Duplicated! #{symbol}, #{date}"
      #end
    end
  end
end