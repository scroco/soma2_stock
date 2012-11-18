class CreateTradingSignals < ActiveRecord::Migration
  def change
    create_table :trading_signals do |t|
      t.datetime  :entry_date
      t.datetime  :exit_date

      t.timestamps
    end

    add_column('trading_signals', 'stock_code_id', :integer, :index => true)
    add_column('trading_signals', 'trading_strategy_id', :integer, :index => true)
  end
end


