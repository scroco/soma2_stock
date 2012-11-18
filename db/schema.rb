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

ActiveRecord::Schema.define(:version => 20121118061629) do

  create_table "day_candles", :force => true do |t|
    t.string   "symbol"
    t.string   "date"
    t.integer  "o"
    t.integer  "h"
    t.integer  "l"
    t.integer  "c"
    t.integer  "v"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "firm_daily_datum_id"
  end

  add_index "day_candles", ["date", "symbol"], :name => "index_day_candles_on_date_and_symbol", :unique => true
  add_index "day_candles", ["symbol"], :name => "day_candles_symbol_fk"

  create_table "firm_daily_data", :force => true do |t|
    t.float    "per"
    t.float    "pbr"
    t.float    "pcr"
    t.float    "pdr"
    t.float    "psr"
    t.float    "market_capitalization"
    t.float    "iroi"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "firm_data", :force => true do |t|
    t.datetime "date"
    t.string   "period"
    t.integer  "working_capital"
    t.integer  "quick_assets"
    t.integer  "inventories"
    t.integer  "prepaid_incomeTaxes"
    t.integer  "other_current_assets"
    t.integer  "non_current_assets"
    t.integer  "investment_assets"
    t.integer  "tangible_assets"
    t.integer  "intangible_assets"
    t.integer  "biological_assets"
    t.integer  "investment_real_assets"
    t.integer  "assets_held_for_sale"
    t.integer  "deferred_income_tax_assets"
    t.integer  "other_non_current_assets"
    t.integer  "total_assets"
    t.integer  "total_assets_utem"
    t.integer  "floating_debt"
    t.integer  "non_current_liabilities"
    t.integer  "liabilities"
    t.integer  "liabilities_utem"
    t.integer  "controlling_shareholders_equity"
    t.integer  "capital"
    t.integer  "capital_surplus"
    t.integer  "other_capital"
    t.integer  "accumulated_other_comprehensive_income"
    t.integer  "retained_earning"
    t.integer  "total_stockholders_equity"
    t.integer  "total_stockholders_equity_utem"
    t.integer  "bps"
    t.integer  "sales"
    t.integer  "cost_of_goods_sold"
    t.integer  "gross_profit"
    t.integer  "selling_expenses"
    t.integer  "other_operation_income"
    t.integer  "other_operating_revenue"
    t.integer  "other_operation_expense"
    t.integer  "operating_profit"
    t.integer  "operating_profit_kgaap"
    t.integer  "financial_income"
    t.integer  "financial_Revenue"
    t.integer  "financial_expense"
    t.integer  "other_non_operating_income"
    t.integer  "other_income"
    t.integer  "other_costs"
    t.integer  "subsidiaries_income"
    t.integer  "profit_before_income_tax"
    t.integer  "income_tax"
    t.integer  "net_income"
    t.integer  "controlling_interests_in_net_income"
    t.integer  "non_controlling_interest_in_net_income"
    t.integer  "consolidated_net_controlling_stake"
    t.integer  "net_income_utem"
    t.integer  "other_comprehensive_income"
    t.integer  "total_comprehensive_income"
    t.integer  "cashflows_from_operating"
    t.integer  "expenses_without_cash_outflow"
    t.integer  "income_without_cash_inflow"
    t.integer  "operating_assets_liabilities_fluctuations"
    t.integer  "cashflow_from_investing"
    t.integer  "cash_inflow_from_investing"
    t.integer  "cash_outflow_from_investing"
    t.integer  "cashflow_from_financing"
    t.integer  "cash_inflow_from_financing"
    t.integer  "cash_outflow_from_financing"
    t.integer  "change_in_cash"
    t.integer  "beginning_cash"
    t.integer  "end_cash"
    t.integer  "eps"
    t.integer  "eps_utem"
    t.float    "per"
    t.integer  "bps_utem"
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
    t.float    "net_profit_margin"
    t.float    "operating_profit_margin_gaap"
    t.float    "operating_profit_margin"
    t.float    "sales_growth"
    t.float    "operating_profit_growth_gaap"
    t.float    "operating_profit_growth"
    t.float    "net_profit_growth"
    t.float    "equity_growth"
    t.float    "debt_to_equity_ratio"
    t.float    "current_ratio"
    t.float    "interest_coverage_ratio"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.integer  "stock_code_id"
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
