class CreateAssetStrategies < ActiveRecord::Migration
  def change
    create_table :asset_strategies do |t|
      t.string  :name
      t.string  :strategy

      t.timestamps
    end
  end
end
