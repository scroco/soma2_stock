class AddIndexToDateOfTradingSignals < ActiveRecord::Migration
  def change
    add_index :trading_signals, [:entry_date]
    add_index :trading_signals, [:exit_date]
  end
end