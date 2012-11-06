class DropFirmData < ActiveRecord::Migration
  def change
    drop_table :firm_data
  end

end
