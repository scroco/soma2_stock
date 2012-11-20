class AddIndexToFirmData < ActiveRecord::Migration
  def change
    add_index :firm_data, [:date]
  end
end
