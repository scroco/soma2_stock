class CreateTradingStrategies < ActiveRecord::Migration
  def change
    create_table :trading_strategies do |t|
      t.string    :name

      t.timestamps
    end
  end
end
