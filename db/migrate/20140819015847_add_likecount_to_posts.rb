class AddLikecountToPosts < ActiveRecord::Migration
  def change
  	add_column :posts, :like_count, :int
  	add_index :posts, :like_count
  end
end
