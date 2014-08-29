class AddMembercountToGroup < ActiveRecord::Migration
  def change
  	add_column :groups, :members_count, :int
  	add_index :groups, :members_count
  end
end
