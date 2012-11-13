# coding: utf-8
require 'rubygems'

#camulcase -> snakecase  :: converting camucase to underscore in ruby
def to_snake_case(str)
  return downcase if match()
end

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
  begin
    strlist = str.split(',')

    tot = ''
    for tmp in strlist
      tot = tot + tmp
    end

    return tot.to_f
  rescue
    return "error"
  end

end

#한글 카테고리와 DB schema 매칭, 재무상태표
def valuename_translator(ko, value, rec_value)
  if ko == "유동자산" then
    rec_value[:working_capital] = value
  elsif ko == "당좌자산" then
    rec_value[:quick_assets] = value
    #puts "#{ko} quickAssets #{value}"
  elsif ko == "재고자산" then
    rec_value[:inventories] = value
  elsif ko == "선급법인세" then
    rec_value[:prepaid_income_taxes] = value
  elsif ko == "기타유동자산" then
    rec_value[:other_current_assets] = value
  elsif ko == "비유동자산" then
    rec_value[:non_current_assets] = value
  elsif ko == "투자자산" then
    rec_value[:investment_assets] = value
  elsif ko == "유형자산" then
    rec_value[:tangible_assets] = value
  elsif ko == "무형자산" then
    rec_value[:intangible_assets] = value
  elsif ko == "생물자산" then
    rec_value[:biological_assets] = value
  elsif ko == "투자부동산" then
    rec_value[:investment_real_assets] = value
  elsif ko == "매각예정자산" then
    rec_value[:assets_held_for_sale] = value
  elsif ko == "이연법인세자산" then
    rec_value[:deferred_income_tax_assets] = value
  elsif ko == "기타 비유동자산" then
    rec_value[:other_non_current_assets] = value
  elsif ko == "자산총계" then
    rec_value[:total_assets] = value
  elsif ko == "자산총계(지분법적용,주석)" then
    rec_value[:total_assets_utem] = value
  elsif ko == "유동부채" then
    rec_value[:floating_debt] = value
  elsif ko == "비유동부채" then
    rec_value[:non_current_liabilities] = value
  elsif ko == "부채총계" then
    rec_value[:liabilities] = value
  elsif ko == "부채총계(지분법적용,주석)" then
    rec_value[:liabilities_utem] = value
  elsif ko == "지배주주지분" then
    rec_value[:controlling_shareholders_equity] = value
  elsif ko == "자본금" then
    rec_value[:capital] = value
  elsif ko == "자본잉여금" then
    rec_value[:capital_surplus] = value
  elsif ko == "기타자본" then
    rec_value[:other_capital] = value
  elsif ko == "기타포괄이익누계액" then
    rec_value[:accumulated_other_comprehensive_income] = value
  elsif ko == "이익잉여금" then
    rec_value[:retained_earning] = value
  elsif ko == "자본총계" then
    rec_value[:total_stockholders_equity] = value
  elsif ko == "자본총계(지분법적용,주석)" then
    rec_value[:total_stockholders_equity_utem] = value
  elsif ko == "BPS(Adj.,지분법적용,주석)" then
    rec_value[:bps] = value
  end

end


def valuename_translator2(ko, value, rec_value)
  if ko == "매출액(수익)" then
    rec_value[:sales] = value
  elsif ko == "매출원가" then
    rec_value[:cost_of_goods_sold] = value
  elsif ko == "매출총이익" then
    rec_value[:gross_profit] = value
  elsif ko == "판매비와관리비" then
    rec_value[:selling_expenses] = value
  elsif ko == "기타영업손익" then
    rec_value[:other_operation_income] = value
  elsif ko == "기타영업수익" then
    rec_value[:other_operating_revenue] = value
  elsif ko == "기타영업비용" then
    rec_value[:other_operation_expense] = value
  elsif ko == "영업이익" then
    rec_value[:operating_profit] = value
    #puts "#{ko} operatingProfit #{value}"
  elsif ko == "*영업이익(K-GAAP)" then
    rec_value[:operating_profit_kgaap] = value
  elsif ko == "금융손익" then
    rec_value[:financial_income] = value
  elsif ko == "금융수익" then
    rec_value[:financial_revenue] = value
  elsif ko == "금융비용" then
    rec_value[:financial_expense] = value
  elsif ko == "기타영업외손익" then
    rec_value[:other_non_operating_income] = value
  elsif ko == "기타수익" then
    rec_value[:other_income] = value
  elsif ko == "기타비용" then
    rec_value[:other_costs] = value
  elsif ko == "종속기업관련손익" then
    rec_value[:subsidiaries_income] = value
  elsif ko == "법인세비용차감전계속사업이익" then
    rec_value[:profit_before_income_tax] = value
  elsif ko == "법인세비용" then
    rec_value[:income_tax] = value
  elsif ko == "당기순이익" then
    rec_value[:net_income] = value
  elsif ko == "지배지분 순이익" then
    rec_value[:controlling_interests_in_net_income] = value
  elsif ko == "비지배지분 순이익" then
    rec_value[:non_controlling_interest_in_net_income] = value
  elsif ko == "*지배지분 연결순이익" then
    rec_value[:consolidated_net_controlling_stake] = value
  elsif ko == "당기순이익(지분법적용,주석)" then
    rec_value[:net_income_utem] = value
  elsif ko == "기타포괄이익" then
    rec_value[:other_comprehensive_income] = value
  elsif ko == "총포괄이익" then
    rec_value[:total_comprehensive_income] = value
  end

end

def valuename_translator3(ko, value, rec_value)
  if ko == "영업활동으로인한현금흐름" then
    rec_value[:cashflows_from_operating] = value
    #puts "#{ko} operatingProfit #{value}"
  elsif ko == "현금유출이 없는 비용" then
    rec_value[:expenses_without_cash_outflow] = value
  elsif ko == "현금유입이 없는 수익" then
    rec_value[:income_without_cash_inflow] = value
  elsif ko == "영업자산·부채 변동" then
    rec_value[:operating_assets_liabilities_fluctuations] = value
  elsif ko == "투자활동으로인한현금흐름" then
    rec_value[:cashflow_from_investing] = value
  elsif ko == "투자활동현금유입액" then
    rec_value[:cash_inflow_from_investing] = value
  elsif ko == "투자활동현금유출액" then
    rec_value[:cash_outflow_from_investing] = value
  elsif ko == "재무활동으로인한현금흐름" then
    rec_value[:cashflow_from_financing] = value
  elsif ko == "재무활동현금유입액" then
    rec_value[:cash_inflow_from_financing] = value
  elsif ko == "재무활동현금유출액" then
    rec_value[:cash_outflow_from_financing] = value
  elsif ko == "현금의 증감" then
    rec_value[:change_in_cash] = value
  elsif ko == "기초의 현금" then
    rec_value[:beginning_cash] = value
  elsif ko == "기말의 현금" then
    rec_value[:end_cash] = value
  end

end