class RemoveCommenterFromComments < ActiveRecord::Migration
  def change
  	remove_column :comments, :commenter
  	add_reference :comments, :user
  end
end
