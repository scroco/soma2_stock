class CreateStockOrders < ActiveRecord::Migration
  def change
    create_table :stock_orders do |t|
      t.string    :type
      t.datetime  :date

      t.timestamps
    end
  end

  add_column('stock_orders', 'trading_strategy_id', :integer, :index => true)
  add_column('stock_orders', 'stock_code_id', :integer)
end
