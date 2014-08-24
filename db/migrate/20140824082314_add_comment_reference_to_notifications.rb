class AddCommentReferenceToNotifications < ActiveRecord::Migration
  def change
  	add_reference :notifications, :comments, index: true
  end
end
