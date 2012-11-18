=begin
처리할 데이터들
    + PER(주가수익률) = 현재주가 / 주당순이익(EPS)
    + PBR(주가순자산비율) = 현재주가 / 주당순자산(BPS)
    + PCR(주가 현금 흐름 비율) = 현재주가 / 주당현금흐름(CPS)
    + PDR(주가 배당 비율) = 현재주가 /  ? ?? 어떻게 하지 ??
    + market capitalization(시가총액) = 한주당 가격 * 발행주식수
    + IROI(초기투자수익률) =  EPS/주가 = PER의 역수
    + PSR(주가매출액비율) - 총 매출액 / 발행주식수 = 주당매출액 , 주가/주당매출액=주가매출액비율
=end


class FirmDataCalculator
  def calculate(symbol, from, to)

    daycandle = DayCandle.all();

  end
  # 실제 클래스에서 실행될 진입점
  # 모든 회사에서 최신 데이터를 계산, 업데이트 한다.
  def run
    stockCode = StockCode.all();

    for stockCode.all().each do |company|
        symbol = company[:Symbol];
        calculate(symbol);
    end
  end
end