class ChangeAttributeTypeOfTradingStrategy < ActiveRecord::Migration
  def change
    change_table :trading_strategies do |t|
      t.change(:strategy, :text)
    end
  end
end
