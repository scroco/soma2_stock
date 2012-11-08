# coding: utf-8
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'net/http'
require 'tasks/api_crawler'

def crawl_firmdata ()


end


#전체 값의 한글 이름을 가져오는 함수
def crawl_typename ()
  list = Array.new

  get_typename(list, "http://www.itooza.com/vclub/y10_page.php?cmp_cd=", "&mode=db&ss=10&sv=1")
  get_typename(list, "http://www.itooza.com/vclub/y10_page.php?cmp_cd=", "&mode=db&ss=10&sv=2&lsmode=1&lkmode=2&accmode=1")
  get_typename(list, "http://www.itooza.com/vclub/y10_page.php?cmp_cd=", "&mode=db&ss=10&sv=4&lsmode=1&lkmode=2&accmode=1")
  # except for value evaluation page
  #get_typename(list, "http://www.itooza.com/vclub/y10_page.php?ss=10&sv=10&cmp_cd=", "&mode=db")

  puts list
  puts "total count : #{list.count}"

end

def get_typename(list, starturl, endurl)
  StockCodes.all().each do |stock_code|
    cod = stock_code[:symbol]
    #puts cod

    doc = Nokogiri::HTML(open(starturl + cod + endurl))

    nameTable = doc.css("table#y10_tb_1")
    namelist = get_data(nameTable, "tr th")

    for tmp in namelist do
      if not list.include? tmp then
        list.push(tmp)
      end
    end
  end

end