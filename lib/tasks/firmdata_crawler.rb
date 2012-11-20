# coding: utf-8
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'net/http'
require 'tasks/api_crawler'

def crawl_firmdata ()

  cnt2=0
  StockCode.find_each do |stock_code|
    #cnt2 = cnt2+1
    #if cnt2 > 1 then
    #  break
    #end

    cod = stock_code[:symbol]
    #cod = "005930"
    puts cod

    h = nil
    h = Hash.new

    puts "재무상태표"
    #재무상태표
    doc = Nokogiri::HTML(open("http://www.itooza.com/vclub/y10_page.php?cmp_cd=#{cod}&mode=db&ss=10&sv=1"))

    nameTable = doc.css("table#y10_tb_1")
    namelist = get_data(nameTable, "tr th")
    namelist.delete_at(0) #쓰레기 값 제거

    docTable = doc.css("table#y10_tb_2")
    #puts docTable

    date = get_data(docTable, "thead tr th span")
    #puts date
    valuelist = get_data(docTable, "tbody tr td")
    #puts valuelist
    valuelist.delete_at(0) #쓰레기 값 제거

    for tmp_date in date do
      tup = FirmDatum.where(:date => Date.strptime(tmp_date, '%Y.%m')).where(:stock_code_id => stock_code).first
      if tup then
        h[tmp_date] = tup
      end
    end

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

        tup = h[tmp_date]
        if tup == nil then
          #[tmp_date] = stock_code.build_FirmDatum
          h[tmp_date] = FirmDatum.new(:stock_code => stock_code)
          tup = h[tmp_date]
          tup[:date] = Date.strptime(tmp_date, '%Y.%m')

          #h[tmp] = FirmDatum.new(:stock_code => stock_code)
          #tup = h[tmp]
          #tup[:date] = Date.strptime(tmp, '%Y.%m')
        end

        tup[:date] = Date.strptime(tmp_date, '%Y.%m')
        valuename_translator(tmp_name, strtoint(value), tup)

      end
    end

    puts "손익계산서"
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

    #puts valuelist[0]
    #puts valuelist[1]

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

        tup = h[tmp_date]
        if tup == nil then
          #[tmp_date] = stock_code.build_FirmDatum
          h[tmp_date] = FirmDatum.new(:stock_code => stock_code)
          tup = h[tmp_date]
          tup[:date] = Date.strptime(tmp_date, '%Y.%m')
        end

        valuename_translator2(tmp_name, strtoint(value), tup)

      end
    end

    puts "현금흐름표"
    #현금흐름표
    doc = Nokogiri::HTML(open("http://www.itooza.com/vclub/y10_page.php?cmp_cd=#{cod}&mode=db&ss=10&sv=4&lsmode=1&lkmode=2&accmode=1"))

    nameTable = doc.css("table#y10_tb_1")
    namelist = get_data(nameTable, "tr th")
    namelist.delete_at(0) #쓰레기 값 제거

    docTable = doc.css("table#y10_tb_2")
    #puts docTable

    date = get_data(docTable, "thead tr th span")
    valuelist = get_data(docTable, "tbody tr td")
    #puts valuelist
    if valuelist[0] == "" then
      valuelist.delete_at(0) #쓰레기 값 제거
    end

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

        tup = h[tmp_date]
        if tup == nil then
          #[tmp_date] = stock_code.build_FirmDatum
          h[tmp_date] = FirmDatum.new(:stock_code => stock_code)
          tup = h[tmp_date]
          tup[:date] = Date.strptime(tmp_date, '%Y.%m')
        end
        valuename_translator3(tmp_name, strtoint(value), tup)

      end

    end


    puts "가치평가"
    #가치평가
    doc = Nokogiri::HTML(open("http://www.itooza.com/vclub/y10_page.php?ss=10&sv=10&cmp_cd=#{cod}&mode=db"))

    docTable = doc.css("table#y10_tb_1")
    #puts docTable

    #기간
    date = get_data(docTable, "thead tr th span")
    #puts date

    #EPS(지배)
    veps = get_data(docTable, "tbody tr#node-2 td")

    #EPS지분법적용
    vepsUTEM = get_data(docTable, "tr#node-3 td")

    #PER
    vper = get_data(docTable, "tr#node-4 td")

    #BPS지분법적용
    vbpsUTEM = get_data(docTable, "tr#node-5 td")

    #PBR
    vpbr = get_data(docTable, "tr#node-6 td")

    #CFPS
    vcfps = get_data(docTable, "tr#node-7 td")

    #PCR
    vpcr = get_data(docTable, "tr#node-8 td")

    #SPS
    vsps = get_data(docTable, "tr#node-9 td")

    #PSR
    vpsr = get_data(docTable, "tr#node-10 td")

    #ROE
    vroe = get_data(docTable, "tr#node-12 td")

    #ROS
    vros = get_data(docTable, "tr#node-13 td")

    #SA
    vsa = get_data(docTable, "tr#node-14 td")

    #AE
    vae = get_data(docTable, "tr#node-15 td")

    #ROA
    vroa = get_data(docTable, "tr#node-16 td")

    #매출액순이익률
    vnetProfitMargin = get_data(docTable, "tr#node-17 td")

    #매출액영업이익률(GAAP)
    voperatingProfitMarginGAAP = get_data(docTable, "tr#node-18 td")

    #매출액영업이익률(보고서)
    voperatingProfitMargin = get_data(docTable, "tr#node-19 td")

    #매출액증가율
    vsalesGrowth = get_data(docTable, "tr#node-21 td")

    #영업이익증가율(GAAP)
    voperatingProfitGrowthGAAP = get_data(docTable, "tr#node-22 td")

    #영업이익증가율(보고서)
    voperatingProfitGrowth = get_data(docTable, "tr#node-23 td")

    #순이익증가율(지배)
    vnetProfitGrowth = get_data(docTable, "tr#node-24 td")

    #자기자본증가율(지배)
    vequityGrowth = get_data(docTable, "tr#node-25 td")

    #부채비율(%)
    vdebtToEquityRatio = get_data(docTable, "tr#node-27 td")

    #유동비율(%)
    vcurrentRatio = get_data(docTable, "tr#node-28 td")

    #이자보상배율(배)
    vInterestCoverageRatio = get_data(docTable, "tr#node-29 td")

    cnt = 0
    for tmp in date do
      tup = h[tmp]
      if tup == nil then
        #[tmp_date] = stock_code.build_FirmDatum
        h[tmp] = FirmDatum.new(:stock_code => stock_code)
        tup = h[tmp]
        tup[:date] = Date.strptime(tmp, '%Y.%m')
      end

      #valuename_translator2(tmp_name, strtoint(value), tup)

      if veps[cnt] != "N/A"
        tup[:eps] = strtoint(veps[cnt])
      end
      if vepsUTEM[cnt] != "N/A"
        tup[:eps_utem] = strtoint(vepsUTEM[cnt])
      end
      if vper[cnt] != "N/A"
        tup[:per] = strtoint(vper[cnt])
      end
      if vbpsUTEM[cnt] != "N/A"
        tup[:bps_utem] = strtoint(vbpsUTEM[cnt])
      end
      if vpbr[cnt] != "N/A"
        tup[:pbr] = strtoint(vpbr[cnt])
      end
      if vcfps[cnt] != "N/A"
        tup[:cfps] = strtoint(vcfps[cnt])
      end
      if vpcr[cnt] != "N/A"
        tup[:pcr] = strtoint(vpcr[cnt])
      end
      if vsps[cnt] != "N/A"
        tup[:sps] = strtoint(vsps[cnt])
      end
      if vpsr[cnt] != "N/A"
        tup[:psr] = strtoint(vpsr[cnt])
      end
      if vroe[cnt] != "N/A"
        tup[:roe] = strtoint(vroe[cnt])
      end
      if vros[cnt] != "N/A"
        tup[:ros] = strtoint(vros[cnt])
      end
      if vsa[cnt] != "N/A"
        tup[:sa] = strtoint(vsa[cnt])
      end
      if vae[cnt] != "N/A"
        tup[:ae] = strtoint(vae[cnt])
      end
      if vroa[cnt] != "N/A"
        tup[:roa] = strtoint(vroa[cnt])
      end
      if vnetProfitMargin[cnt] != "N/A"
        tup[:net_profit_margin] = strtoint(vnetProfitMargin[cnt])
      end
      if voperatingProfitMarginGAAP[cnt] != "N/A"
        tup[:net_profit_margin_gaap] = strtoint(voperatingProfitMarginGAAP[cnt])
      end
      if voperatingProfitMargin[cnt] != "N/A"
        tup[:operating_profit_margin] = strtoint(voperatingProfitMargin[cnt])
      end
      if vsalesGrowth[cnt] != "N/A"
        tup[:sales_growth] = strtoint(vsalesGrowth[cnt])
      end
      if voperatingProfitGrowthGAAP[cnt] != "N/A"
        tup[:operating_profit_growth_gaap] = strtoint(voperatingProfitGrowthGAAP[cnt])
      end
      if voperatingProfitGrowth[cnt] != "N/A"
        tup[:operating_profit_growth] = strtoint(voperatingProfitGrowth[cnt])
      end
      if vnetProfitGrowth[cnt] != "N/A"
        tup[:net_profit_growth] = strtoint(vnetProfitGrowth[cnt])
      end
      if vequityGrowth[cnt] != "N/A"
        tup[:equity_growth] = strtoint(vequityGrowth[cnt])
      end
      if vdebtToEquityRatio[cnt] != "N/A"
        tup[:debt_to_equity_ratio] = strtoint(vdebtToEquityRatio[cnt])
      end
      if vcurrentRatio[cnt] != "N/A"
        tup[:current_ratio] = strtoint(vcurrentRatio[cnt])
      end
      if vInterestCoverageRatio[cnt] != "N/A"
        tup[:interest_coverage_ratio] = strtoint(vInterestCoverageRatio[cnt])
      end

      #if voperatingProfitGrowth[cnt] != "N/A"
      #  puts "#{cod}, operatingProfitGrowth, #{strtoint(voperatingProfitGrowth[cnt])}, #{Date.strptime(tmp, '%Y.%m')}, db"
      #end

      cnt = cnt+1
    end


    h.each { |key, value|
      tup = value
      #puts "save #{key} : #{tup[:date]}"
      #puts "#{tup[:date]} #{tup[:interest_coverage_ratio]} \n"
      puts "save #{key} #{tup.save!}"
    }

  end

  #puts FirmDatum.all()

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