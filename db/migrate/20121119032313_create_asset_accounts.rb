class CreateAssetAccounts < ActiveRecord::Migration
  def change
    create_table :asset_accounts do |t|
      t.integer :base_asset
      t.integer :current_asset
      t.datetime  :start_date
      t.datetime  :end_date
      t.datetime  :tested_date
      t.integer :constant_asset
      t.integer :trading_strategy_id
      t.integer :asset_strategy_id

      t.timestamps
    end
  end
end
