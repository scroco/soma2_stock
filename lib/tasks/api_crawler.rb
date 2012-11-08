# coding: utf-8
require 'rubygems'

#table안에 들어있는 text들을 array 형태로 반환
def get_data(doc, cssstr)

  temp = doc.css(cssstr)
  arr = Array.new
  cnt=0
  for t in temp do
    #puts t.text + ' '
    arr[cnt] = t.text
    #arr.push(t.text)
    cnt = cnt+1
  end
  return arr
end

#숫자 표현된 string을 숫자로 바꿈(콤마 제거)
def strtoint(str)
  strlist = str.split(',')

  tot = ''
  for tmp in strlist
    tot = tot + tmp
  end
  return tot.to_f
end

#한글 카테고리와 DB schema 매칭, 재무상태표
def valuename_translator(ko, value, rec_value)
  if ko == "유동자산" then
    rec_value[:workingCapital] = value
  elsif ko == "당좌자산" then
    rec_value[:quickAssets] = value
    #puts "#{ko} quickAssets #{value}"
  elsif ko == "재고자산" then
    rec_value[:inventories] = value
  elsif ko == "선급법인세" then
    rec_value[:prepaidIncomeTaxes] = value
  elsif ko == "기타유동자산" then
    rec_value[:otherCurrentAssets] = value
  elsif ko == "비유동자산" then
    rec_value[:nonCurrentAssets] = value
  elsif ko == "투자자산" then
    rec_value[:investmentAssets] = value
  elsif ko == "유형자산" then
    rec_value[:tangibleAssets] = value
  elsif ko == "무형자산" then
    rec_value[:intangibleAssets] = value
  elsif ko == "생물자산" then
    rec_value[:biologicalAssets] = value
  elsif ko == "투자부동산" then
    rec_value[:investmentRealAssets] = value
  elsif ko == "매각예정자산" then
    rec_value[:assetsHeldForSale] = value
  elsif ko == "이연법인세자산" then
    rec_value[:deferredIncomeTaxAssets] = value
  elsif ko == "기타 비유동자산" then
    rec_value[:otherNonCurrentAssets] = value
  elsif ko == "자산총계" then
    rec_value[:totalAssets] = value
  elsif ko == "자산총계(지분법적용,주석)" then
    rec_value[:totalAssetsUTEM] = value
  elsif ko == "유동부채" then
    rec_value[:floatingDebt] = value
  elsif ko == "비유동부채" then
    rec_value[:nonCurrentLiabilities] = value
  elsif ko == "부채총계" then
    rec_value[:liabilities] = value
  elsif ko == "부채총계(지분법적용,주석)" then
    rec_value[:liabilitiesUTEM] = value
  elsif ko == "지배주주지분" then
    rec_value[:controllingShareHoldersEquity] = value
  elsif ko == "자본금" then
    rec_value[:capital] = value
  elsif ko == "자본잉여금" then
    rec_value[:capitalSurplus] = value
  elsif ko == "기타자본" then
    rec_value[:otherCapital] = value
  elsif ko == "기타포괄이익누계액" then
    rec_value[:accumulatedOtherComprehensiveIncome] = value
  elsif ko == "이익잉여금" then
    rec_value[:retainedEarning] = value
  elsif ko == "자본총계" then
    rec_value[:totalStockholdersEquity] = value
  elsif ko == "자본총계(지분법적용,주석)" then
    rec_value[:totalStockholdersEquityUTEM] = value
  elsif ko == "BPS(Adj.,지분법적용,주석)" then
    rec_value[:bps] = value
  end

end


def valuename_translator2(ko, value, rec_value)
  if ko == "매출액(수익)" then
    rec_value[:sales] = value
  elsif ko == "매출원가" then
    rec_value[:costOfGoodsSold] = value
  elsif ko == "매출총이익" then
    rec_value[:grossProfit] = value
  elsif ko == "판매비와관리비" then
    rec_value[:sellingExpenses] = value
  elsif ko == "기타영업손익" then
    rec_value[:otherOperationIncome] = value
  elsif ko == "기타영업수익" then
    rec_value[:otherOperatingRevenue] = value
  elsif ko == "기타영업비용" then
    rec_value[:otherOperationExpense] = value
  elsif ko == "영업이익" then
    rec_value[:operatingProfit] = value
    #puts "#{ko} operatingProfit #{value}"
  elsif ko == "*영업이익(K-GAAP)" then
    rec_value[:operatingProfitKgaap] = value
  elsif ko == "금융손익" then
    rec_value[:financialIncome] = value
  elsif ko == "금융수익" then
    rec_value[:financialRevenue] = value
  elsif ko == "금융비용" then
    rec_value[:financialExpense] = value
  elsif ko == "기타영업외손익" then
    rec_value[:otherNonOperatingIncome] = value
  elsif ko == "기타수익" then
    rec_value[:otherIncome] = value
  elsif ko == "기타비용" then
    rec_value[:otherCosts] = value
  elsif ko == "종속기업관련손익" then
    rec_value[:subsidiariesIncome] = value
  elsif ko == "법인세비용차감전계속사업이익" then
    rec_value[:profitBeforeIncomeTax] = value
  elsif ko == "법인세비용" then
    rec_value[:incomeTax] = value
  elsif ko == "당기순이익" then
    rec_value[:netIncome] = value
  elsif ko == "지배지분 순이익" then
    rec_value[:controllingInterestsInNetIncome] = value
  elsif ko == "비지배지분 순이익" then
    rec_value[:nonControllingInterestInNetIncome] = value
  elsif ko == "*지배지분 연결순이익" then
    rec_value[:consolidatedNetControllingStake] = value
  elsif ko == "당기순이익(지분법적용,주석)" then
    rec_value[:netIncomeUTEM] = value
  elsif ko == "기타포괄이익" then
    rec_value[:otherComprehensiveIncome] = value
  elsif ko == "총포괄이익" then
    rec_value[:totalComprehensiveIncome] = value
  end

end

def valuename_translator3(ko, value, rec_value)
  if ko == "매출액(수익)" then
    rec_value[:sales] = value
    #puts "#{ko} operatingProfit #{value}"
  elsif ko == "매출원가" then
    rec_value[:costOfGoodsSold] = value
  elsif ko == "매출총이익" then
    rec_value[:grossProfit] = value
  elsif ko == "판매비와관리비" then
    rec_value[:sellingExpenses] = value
  elsif ko == "기타영업손익" then
    rec_value[:otherOperationIncome] = value
  elsif ko == "기타영업수익" then
    rec_value[:otherOperatingRevenue] = value
  elsif ko == "기타영업비용" then
    rec_value[:otherOperationExpense] = value
  elsif ko == "영업이익" then
    rec_value[:operatingProfit] = value
  elsif ko == "*영업이익(K-GAAP)" then
    rec_value[:operatingProfitKgaap] = value
  elsif ko == "금융손익" then
    rec_value[:financialIncome] = value
  elsif ko == "금융수익" then
    rec_value[:financialRevenue] = value
  elsif ko == "금융비용" then
    rec_value[:financialExpense] = value
  elsif ko == "기타영업외손익" then
    rec_value[:otherNonOperatingIncome] = value
  elsif ko == "기타수익" then
    rec_value[:otherIncome] = value
  elsif ko == "기타비용" then
    rec_value[:otherCosts] = value
  elsif ko == "종속기업관련손익" then
    rec_value[:subsidiariesIncome] = value
  elsif ko == "법인세비용차감전계속사업이익" then
    rec_value[:profitBeforeIncomeTax] = value
  elsif ko == "법인세비용" then
    rec_value[:incomeTax] = value
  elsif ko == "당기순이익" then
    rec_value[:netIncome] = value
  elsif ko == "지배지분 순이익" then
    rec_value[:controllingInterestsInNetIncome] = value
  elsif ko == "비지배지분 순이익" then
    rec_value[:nonControllingInterestInNetIncome] = value
  elsif ko == "*지배지분 연결순이익" then
    rec_value[:consolidatedNetControllingStake] = value
  elsif ko == "당기순이익(지분법적용,주석)" then
    rec_value[:netIncomeUTEM] = value
  elsif ko == "기타포괄이익" then
    rec_value[:otherComprehensiveIncome] = value
  elsif ko == "총포괄이익" then
    rec_value[:totalComprehensiveIncome] = value
  end

end