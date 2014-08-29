#coding: utf-8
class Notification < ActiveRecord::Base
	include Rails.application.routes.url_helpers

	belongs_to :user
	belongs_to :comment

	scope :timeline, -> {order(created_at: :desc)}

	before_save do
		return if self.blank?
		return if self.comment.blank?
		comment = self.comment
		self.url = post_path(self.comment.post)
		self.content = "收到了新的回复"
	end
	
end
