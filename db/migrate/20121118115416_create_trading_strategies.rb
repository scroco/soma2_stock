class CreateTradingStrategies < ActiveRecord::Migration
  def change
    create_table :trading_strategies do |t|

      t.timestamps
    end
  end
end
