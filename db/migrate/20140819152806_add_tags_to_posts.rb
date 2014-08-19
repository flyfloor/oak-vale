class AddTagsToPosts < ActiveRecord::Migration
  def change
  	remove_column :tags, :post_id
  	add_reference :tags, :post
  	add_reference :posts, :tag
  end
end
