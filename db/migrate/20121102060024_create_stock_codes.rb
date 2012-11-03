class CreateStockCodes < ActiveRecord::Migration
  def change
    create_table :stock_codes do |t|
      t.column  :issue_code,  :string
      t.column  :symbol,  :string
      t.column  :name,  :string
      t.column  :eng_name,  :string
      t.column  :standard_code,  :string
      t.column  :short_code,  :string
      t.column  :market_type,  :string

      t.column  :crawl_date,  :DateTime

      t.timestamps
    end

    add_index :stock_codes, [:symbol], :unique => true
  end
end
