class CreateFirmDailyData < ActiveRecord::Migration
  def change
    create_table :firm_daily_data do |t|
      t.float :per
      t.float :pbr
      t.float :pcr
      t.float :pdr
      t.float :psr
      t.float :market_capitalization
      t.float :iroi

      t.timestamps
    end
    add_column('day_candles', 'firm_daily_datum_id', :integer, :index => true)
  end
end
