# coding: utf-8
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'iconv'
require 'tasks/chart_crawler'

def crawl_code ()
  pg_no = 1

  while true
    doc = Nokogiri::HTML(
        open("http://isin.krx.co.kr/jsp/BA_LT131.jsp?pg_no=#{pg_no}").read, nil, 'euc-kr')

    #table = doc.css("form input table table")

    # 각 데이터 튜플
    odd_tuples = doc.xpath("//tr[@bgcolor='#E5E5E5']")
    even_tuples = doc.xpath("//tr[@bgcolor='#EDEDED']")

    if even_tuples.size==1 and odd_tuples.size==0
      puts "ENDED"
      break
    end

    odd_tuples.each do |tuple|
      parsing_each_tuple(tuple)
    end

    even_tuples.each do |tuple|
      parsing_each_tuple(tuple)
    end

    pg_no += 1
  end

  ## 업종별 URL 얻어오기
  #upjong_links = doc.xpath("//div[@id='contentarea_left']/table[@class='type_1']//a[contains(@href,'/sise/sise_group_detail.nhn')]/@href")
  #
  ## 각 업종별로 종목 Code 얻어오기
  #upjong_links.each do |upjong|
  #  # parsing bug
  #  urlString = upjong.to_s.gsub("upjong=", "upjong&no=")
  #
  #  # 업종 페이지에서 code 포함된 링크 얻어오기
  #  subdoc = Nokogiri::XML(open("http://finance.naver.com/" + urlString), nil, 'euc-kr')
  #  code_links = subdoc.xpath("//div[@id='contentarea']//a[contains(@href,'main.nhn?code=')]")
  #
  #  # 각 code 링크
  #  code_links.each do |code_link|
  #    # <a href="/item/main.nhn?code=004780">대륙제관</a>
  #    company_name_node = code_link.xpath("./text()")
  #    company = Iconv.iconv("utf8", "euc-kr", company_name_node.to_s);
  #
  #    code_url = code_link.xpath("./@href").to_s
  #    code = code_url[/code=(......)/, 1]
  #    store_code(code, company)
  #
  #  end
  #end
end


def parsing_each_tuple(tuple)
  columns = tuple.css("td")

  if columns.size == 6
    #issue_code, symbol, name, eng_name, standard_code, short_code, market_type
    issue_code = columns[0].inner_text
    name = columns[1].inner_text
    eng_name = columns[2].inner_text
    standard_code = columns[3].inner_text
    short_code = columns[4].inner_text
    market_type = columns[5].inner_text

    if market_type.include? "상장"
      if !(market_type.include? "폐지")
        symbol = short_code[-6, 6]
        store_code(issue_code, symbol, name, eng_name, standard_code, short_code, market_type)
      end
    end
  end
end

def store_code (issue_code, symbol, name, eng_name, standard_code, short_code, market_type)
  # attr_accessible :issue_code, :symbol, :name, :eng_name, :standard_code, :short_code, :market_type, :crawl_date
  if !StockCode.duplicated?(symbol)
    begin
      StockCode.create(:issue_code => issue_code, :symbol => symbol, :name => name, :eng_name => eng_name,
        :standard_code => standard_code, :short_code => short_code, :market_type => market_type)
    rescue
      puts $!
    end
    puts "#{symbol}, #{name}"
  else
    puts "Duplicated! #{symbol}, #{name}"
    s = StockCode.where(:symbol => symbol).first
    s[:name] = name
    s[:eng_name] = eng_name
    s.save
  end
end
