# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121108161520) do

  create_table "day_candles", :force => true do |t|
    t.string   "symbol"
    t.string   "date"
    t.integer  "o"
    t.integer  "h"
    t.integer  "l"
    t.integer  "c"
    t.integer  "v"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "day_candles", ["date", "symbol"], :name => "index_day_candles_on_date_and_symbol", :unique => true
  add_index "day_candles", ["symbol"], :name => "day_candles_symbol_fk"

  create_table "firm_data", :force => true do |t|
    t.datetime "date"
    t.string   "period"
    t.integer  "workingCapital"
    t.integer  "quickAssets"
    t.integer  "inventories"
    t.integer  "prepaidIncomeTaxes"
    t.integer  "otherCurrentAssets"
    t.integer  "nonCurrentAssets"
    t.integer  "investmentAssets"
    t.integer  "tangibleAssets"
    t.integer  "intangibleAssets"
    t.integer  "biologicalAssets"
    t.integer  "investmentRealAssets"
    t.integer  "assetsHeldForSale"
    t.integer  "deferredIncomeTaxAssets"
    t.integer  "otherNonCurrentAssets"
    t.integer  "totalAssets"
    t.integer  "totalAssetsUTEM"
    t.integer  "floatingDebt"
    t.integer  "nonCurrentLiabilities"
    t.integer  "liabilities"
    t.integer  "liabilitiesUTEM"
    t.integer  "controllingShareHoldersEquity"
    t.integer  "capital"
    t.integer  "capitalSurplus"
    t.integer  "otherCapital"
    t.integer  "accumulatedOtherComprehensiveIncome"
    t.integer  "retainedEarning"
    t.integer  "totalStockholdersEquity"
    t.integer  "totalStockholdersEquityUTEM"
    t.integer  "bps"
    t.integer  "sales"
    t.integer  "costOfGoodsSold"
    t.integer  "grossProfit"
    t.integer  "sellingExpenses"
    t.integer  "otherOperationIncome"
    t.integer  "otherOperatingRevenue"
    t.integer  "otherOperationExpense"
    t.integer  "operatingProfit"
    t.integer  "operatingProfitKgaap"
    t.integer  "financialIncome"
    t.integer  "financialRevenue"
    t.integer  "financialExpense"
    t.integer  "otherNonOperatingIncome"
    t.integer  "otherIncome"
    t.integer  "otherCosts"
    t.integer  "subsidiariesIncome"
    t.integer  "profitBeforeIncomeTax"
    t.integer  "incomeTax"
    t.integer  "netIncome"
    t.integer  "controllingInterestsInNetIncome"
    t.integer  "nonControllingInterestInNetIncome"
    t.integer  "consolidatedNetControllingStake"
    t.integer  "netIncomeUTEM"
    t.integer  "otherComprehensiveIncome"
    t.integer  "totalComprehensiveIncome"
    t.integer  "cashflowsFromOperating"
    t.integer  "expensesWithoutCashOutflow"
    t.integer  "incomeWithoutCashInflow"
    t.integer  "operatingAssetsLiabilitiesFluctuations"
    t.integer  "cashflowFromInvesting"
    t.integer  "cashInflowFromInvesting"
    t.integer  "cashOutflowFromInvesting"
    t.integer  "cashflowFromFinancing"
    t.integer  "cashInflowFromFinancing"
    t.integer  "cashOutflowFromFinancing"
    t.integer  "changeInCash"
    t.integer  "beginningCash"
    t.integer  "endCash"
    t.integer  "eps"
    t.integer  "epsUTEM"
    t.float    "per"
    t.integer  "bpsUTEM"
    t.float    "pbr"
    t.integer  "cfps"
    t.float    "pcr"
    t.integer  "sps"
    t.float    "psr"
    t.float    "roe"
    t.float    "ros"
    t.float    "sa"
    t.float    "ae"
    t.float    "roa"
    t.float    "netProfitMargin"
    t.float    "operatingProfitMarginGAAP"
    t.float    "operatingProfitMargin"
    t.float    "salesGrowth"
    t.float    "operatingProfitGrowthGAAP"
    t.float    "operatingProfitGrowth"
    t.float    "netProfitGrowth"
    t.float    "equityGrowth"
    t.float    "debtToEquityRatio"
    t.float    "currentRatio"
    t.float    "InterestCoverageRatio"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  create_table "stock_codes", :force => true do |t|
    t.string   "issue_code"
    t.string   "symbol"
    t.string   "name"
    t.string   "eng_name"
    t.string   "standard_code"
    t.string   "short_code"
    t.string   "market_type"
    t.datetime "crawl_date"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "stock_codes", ["symbol"], :name => "index_stock_codes_on_symbol", :unique => true

  add_foreign_key "day_candles", "stock_codes", :name => "day_candles_symbol_fk", :column => "symbol", :primary_key => "symbol"

end
