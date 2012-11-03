# coding: utf-8
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'iconv'
require 'tasks/chart_crawler'

def crawl_code ()
  doc = Nokogiri::XML(
    open("http://finance.naver.com/sise/sise_group.nhn?type=upjong"), nil, 'euc-kr')

  # 업종별 URL 얻어오기
  upjong_links = doc.xpath("//div[@id='contentarea_left']/table[@class='type_1']//a[contains(@href,'/sise/sise_group_detail.nhn')]/@href")

  # 각 업종별로 종목 Code 얻어오기
  upjong_links.each do |upjong|
    # parsing bug
    urlString = upjong.to_s.gsub("upjong=", "upjong&no=")

    # 업종 페이지에서 code 포함된 링크 얻어오기
    subdoc = Nokogiri::XML(open("http://finance.naver.com/" + urlString), nil, 'euc-kr')
    code_links = subdoc.xpath("//div[@id='contentarea']//a[contains(@href,'main.nhn?code=')]")

    # 각 code 링크
    code_links.each do |code_link|
      # <a href="/item/main.nhn?code=004780">대륙제관</a>
      company_name_node = code_link.xpath("./text()")
      company = Iconv.iconv("utf8", "euc-kr", company_name_node.to_s);

      code_url = code_link.xpath("./@href").to_s
      code = code_url[/code=(......)/, 1]
      store_code(code, company)

    end
  end
end

def store_code (code, name)
  if !StockCodes.duplicated?(code)
    begin
      StockCodes.create(:code => code, :name => name)
    rescue
      puts $!
    end
    puts "#{code}, #{name}"
  else
    puts "Duplicated! #{code}, #{name}"
  end
end
