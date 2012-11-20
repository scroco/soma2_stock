=begin
처리할 데이터들
    + PER(주가수익률) = 현재주가 / 주당순이익(EPS)
    + PBR(주가순자산비율) = 현재주가 / 주당순자산(BPS)
    + PCR(주가 현금 흐름 비율) = 현재주가 / 주당현금흐름(CfPS)
    (제외)-  PDR(주가 배당 비율) = 현재주가 / 배당금
    + market capitalization(시가총액) = 한주당 가격 * 발행주식수
    + IROI(초기투자수익률) =  EPS/주가 = PER의 역수
    + PSR(주가매출액비율) - 총 매출액 / 발행주식수 = 주당매출액 , 주가/주당매출액=주가매출액비율
=end

class FirmDataCalculator
  include Celluloid

  def execute day_candles
    #puts(DayCandle.where("firm_daily_datum_id is null and trading_date >= ?", Time.utc(2002,12,31)).to_sql)
    DayCandle.transaction do
      day_candles.each do |day_candle|
        # 없는 애들만 업데이트
        #date = day_candle["date"][0,4] << "-" << day_candle["date"][4,2] << "-" << day_candle["date"][6,2]
        date = day_candle["trading_date"]
        puts(date)

        stock_code = day_candle.stock_code
        puts(stock_code["symbol"])
        puts(stock_code["id"])
        #puts(stock_code.firm_data.where("date <= ?", date).to_sql)

        firm_datum = stock_code.firm_data.where("date <= ?", date).first

        per, pbr, pcr, pdr, psr, market_capitalization, iroi = nil

        if firm_datum == nil

        else
          current_stock_price = day_candle["c"].to_f
          puts "c : #{current_stock_price}"

          puts "eps : #{firm_datum["eps"].to_f}"
          if firm_datum["eps"] == nil or firm_datum["eps"].to_f == 0.0
            per = nil
          else
            per = current_stock_price / firm_datum["eps"].to_f

          end
          puts "per : #{per}"

          puts "pbr : #{pbr}"
          if firm_datum["bps"] == nil or firm_datum["bps"].to_f == 0.0
              pbr = nil
          else
            pbr = current_stock_price / firm_datum["bps"].to_f
          end
          puts "bps : #{firm_datum["bps"].to_f}"
          if firm_datum["cfps"] == nil  or firm_datum["cfps"].to_f == 0.0
            pcr = nil
          else
            pcr = current_stock_price / firm_datum["cfps"].to_f
          end
          puts "cfps : #{firm_datum["cfps"].to_f}"
          puts "pcr : #{pcr}"

          # pdr = current_stock_price / ..
          psr = current_stock_price / firm_datum["sps"].to_f

          if firm_datum["sps"] == nil or firm_datum["sps"].to_f == 0.0
            psr = nil
          else
            psr = current_stock_price / firm_datum["sps"].to_f
          end

          if firm_datum["sales"] == nil or firm_datum["sales"] == nil or firm_datum["sales"] == 0.0 or firm_datum["sales"] == 0.0
            market_capitalization = nil
          else
            market_capitalization = current_stock_price * (firm_datum["sales"].to_f / firm_datum["sps"].to_f)
          end
          puts "market_capitalization : #{market_capitalization}"

          if per == nil or per == 0.0
            iroi = nil
          else
            iroi = 1 / per
          end
        end

        #stock_codes["firm_data"]

        #firmDatum = StockCode.where()
        firm_daily_datum = FirmDailyDatum.create(:per => per, :pbr => pbr, :pcr => pcr , :pdr => nil, :psr => psr, :market_capitalization => market_capitalization, :iroi => iroi)

        day_candle.firm_daily_datum = firm_daily_datum
        day_candle.save()

        #day_candle["firm_daily_datum"] = FirmDailyDatum.create(:per => per, :pbr => pbr, :pcr => pcr , :pdr => pdr, :psr => psr, :market_capitalization => market_capitalization, :iroi => iroi)
      end
    end
  end
end

def firm_data_calculator
  #puts(DayCandle.where("firm_daily_datum_id is null and trading_date >= ?", Time.utc(2002,12,31)).to_sql)

  DayCandle.where("firm_daily_datum_id is null and trading_date >= ?", Time.utc(2002,12,31)).find_each(:batch_size => 5000) do |day_candle|

    #date = day_candle["date"][0,4] << "-" << day_candle["date"][4,2] << "-" << day_candle["date"][6,2]
    date = day_candle["trading_date"]
    puts(date)

    stock_code = day_candle.stock_code
    puts(stock_code["symbol"])
    puts(stock_code["id"])
    #puts(stock_code.firm_data.where("date <= ?", date).to_sql)

    firm_datum = stock_code.firm_data.where("date <= ?", date).first

    per, pbr, pcr, pdr, psr, market_capitalization, iroi = nil

    if firm_datum == nil

    else
      current_stock_price = day_candle["c"].to_f
      puts "c : #{current_stock_price}"

      puts "eps : #{firm_datum["eps"].to_f}"
      if firm_datum["eps"] == nil or firm_datum["eps"].to_f == 0.0
        per = nil
      else
        per = current_stock_price / firm_datum["eps"].to_f

      end
      puts "per : #{per}"

      puts "pbr : #{pbr}"
      if firm_datum["bps"] == nil or firm_datum["bps"].to_f == 0.0
        pbr = nil
      else
        pbr = current_stock_price / firm_datum["bps"].to_f
      end
      puts "bps : #{firm_datum["bps"].to_f}"
      if firm_datum["cfps"] == nil  or firm_datum["cfps"].to_f == 0.0
        pcr = nil
      else
        pcr = current_stock_price / firm_datum["cfps"].to_f
      end
      puts "cfps : #{firm_datum["cfps"].to_f}"
      puts "pcr : #{pcr}"

      # pdr = current_stock_price / ..
      psr = current_stock_price / firm_datum["sps"].to_f

      if firm_datum["sps"] == nil or firm_datum["sps"].to_f == 0.0
        psr = nil
      else
        psr = current_stock_price / firm_datum["sps"].to_f
      end

      if firm_datum["sales"] == nil or firm_datum["sales"] == nil or firm_datum["sales"] == 0.0 or firm_datum["sales"] == 0.0
        market_capitalization = nil
      else
        market_capitalization = current_stock_price * (firm_datum["sales"].to_f / firm_datum["sps"].to_f)
      end
      if per == nil or per == 0.0
        iroi = nil
      else
        iroi = 1 / per
      end
    end

    #stock_codes["firm_data"]

    #firmDatum = StockCode.where()
    firm_daily_datum = FirmDailyDatum.create(:per => per, :pbr => pbr, :pcr => pcr , :pdr => nil, :psr => psr, :market_capitalization => market_capitalization, :iroi => iroi)

    day_candle.firm_daily_datum = firm_daily_datum
    day_candle.save()


    #day_candle["firm_daily_datum"] = FirmDailyDatum.create(:per => per, :pbr => pbr, :pcr => pcr , :pdr => pdr, :psr => psr, :market_capitalization => market_capitalization, :iroi => iroi)
  end
end

=begin

class FirmDataCalculator
  def FirmDataCalculator

  end
  def calculate(symbol, date)

    daycandle = DayCandle.all();


  end
  # 실제 클래스에서 실행될 진입점
  # 모든 회사에서 최신 데이터를 계산, 업데이트 한다.
  def run
    stockCode = StockCode.all();

    for stockCode.all().each do |company|
        symbol = company[:Symbol];
        #calculate(symbol);
    end
  end
end

=end