class AddIndexToAssociationOfAssetAccounts < ActiveRecord::Migration
  def change
    add_index :asset_accounts, [:trading_strategy_id]
    add_index :asset_accounts, [:asset_strategy_id]
  end
end