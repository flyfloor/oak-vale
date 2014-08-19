class AddColumnToUserWithPosts < ActiveRecord::Migration
  def change
  	add_column :user_with_posts, :user_id, :int, index: true
  	add_column :user_with_posts, :post_id, :int, index: true
    add_index :user_with_posts, [:user_id, :post_id], unique: true
  end
end
