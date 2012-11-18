class ChangeAttributePropertyToFirmData < ActiveRecord::Migration
  def up
    change_table :firm_data do |t|
      t.change :date, :date
    end
  end

  def down
    change_table :firm_data do |t|
      t.change :date, :datetime
    end
  end
end
