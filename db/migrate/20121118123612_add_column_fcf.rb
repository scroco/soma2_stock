class AddColumnFcf < ActiveRecord::Migration
  def change
    add_column('firm_data', 'fcf', :integer)
  end

end
