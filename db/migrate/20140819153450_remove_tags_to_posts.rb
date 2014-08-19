class RemoveTagsToPosts < ActiveRecord::Migration
  def change
  	remove_reference :tags, :post
  	remove_reference :posts, :tag
  end
end
