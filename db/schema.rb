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

ActiveRecord::Schema.define(:version => 20121102060024) do

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

end
