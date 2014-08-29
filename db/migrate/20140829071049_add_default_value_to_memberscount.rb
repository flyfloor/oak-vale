class AddDefaultValueToMemberscount < ActiveRecord::Migration
  def change
  	change_table :groups do |t|
  		change_column_default(:groups, :members_count, 0)
  	end
  end
end
