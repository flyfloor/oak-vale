class AddSubercountToTag < ActiveRecord::Migration
  def change
  	add_column :tags, :subscriber_count, :int, default: 0
  	add_index :tags, :subscriber_count
  end
end
