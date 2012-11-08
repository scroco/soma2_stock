# coding: utf-8
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'net/http'
require 'tasks/api_crawler'

def crawl_firmdata ()

  cnt2=0
  StockCode.all().each do |stock_code|
    cnt2 = cnt2+1
    if cnt2 > 1 then
      break
    end

    cod = stock_code[:symbol]
    puts cod

    h = Hash.new

    #재무상태표
    doc = Nokogiri::HTML(open("http://www.itooza.com/vclub/y10_page.php?cmp_cd=#{cod}&mode=db&ss=10&sv=1"))

    nameTable = doc.css("table#y10_tb_1")
    namelist = get_data(nameTable, "tr th")
    namelist.delete_at(0) #쓰레기 값 제거

    docTable = doc.css("table#y10_tb_2")
    #puts docTable

    date = get_data(docTable, "thead tr th span")
    valuelist = get_data(docTable, "tbody tr td")
    #puts valuelist
    valuelist.delete_at(0) #쓰레기 값 제거

    cnt=0
    for tmp_name in namelist do
      #puts tmp_name
      for tmp_date in date do

        value = valuelist[cnt]
        cnt = cnt+1
        #puts value

        if value == "N/A" or value == nil then
          next
        end

        if h[tmp_date] == nil then
          h[tmp_date] = FirmData.new
          #tup = stock_code.build_FirmData
        end

        tup = h[tmp_date]
        valuename_translator(tmp_name, strtoint(value), tup)
        tup[:date] = Date.strptime(tmp_date, '%Y.%m')

      end
    end

    #손익계산서
    doc = Nokogiri::HTML(open("http://www.itooza.com/vclub/y10_page.php?cmp_cd=#{cod}&mode=db&ss=10&sv=2&lsmode=1&lkmode=2&accmode=1"))

    nameTable = doc.css("table#y10_tb_1")
    namelist = get_data(nameTable, "tr th")
    namelist.delete_at(0) #쓰레기 값 제거

    docTable = doc.css("table#y10_tb_2")
    #puts docTable

    date = get_data(docTable, "thead tr th span")
    valuelist = get_data(docTable, "tbody tr td")
    #puts valuelist
    #valuelist.delete_at(0) #쓰레기 값 제거

    puts valuelist[0]
    puts valuelist[1]

    cnt=0
    for tmp_name in namelist do
      #puts tmp_name
      for tmp_date in date do

        value = valuelist[cnt]
        cnt = cnt+1
        #puts value

        if value == "N/A" or value == nil then
          next
        end

        if h[tmp_date] == nil then
          h[tmp_date] = FirmData.new
          #tup = stock_code.build_FirmData
        end

        tup = h[tmp_date]
        valuename_translator2(tmp_name, strtoint(value), tup)
        tup[:date] = Date.strptime(tmp_date, '%Y.%m')

      end
    end


    #h.each { |key, value|
    #  tup = value
    #  puts "#{key} : #{tup[:workingCapital]}"
    ## tup.save
    #}


  end
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