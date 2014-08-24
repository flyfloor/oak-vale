class AddReplyidToNotifications < ActiveRecord::Migration
  def change
  	add_column :notifications, :reply_id, :int
  end
end
