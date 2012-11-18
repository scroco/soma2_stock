class CreateTradingSignals < ActiveRecord::Migration
  def change
    create_table :trading_signals do |t|
      t.datetime  :entry_date
      t.datetime  :exit_date

      t.timestamps
    end
  end
end
