class ChangeCommentReferenceToNotifications < ActiveRecord::Migration
  def change
  	remove_column :notifications, :comments_id
  	add_reference :notifications, :comment, index: true
  end
end
