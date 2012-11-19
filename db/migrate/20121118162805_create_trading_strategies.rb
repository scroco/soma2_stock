class CreateTradingStrategies < ActiveRecord::Migration
  def change
    create_table :trading_strategies do |t|
      t.string  :name
      t.string  :strategy
      t.datetime  :start_date
      t.datetime  :end_date
      t.datetime  :tested_date

      t.timestamps
    end
  end
end

