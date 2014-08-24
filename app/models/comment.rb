class Comment < ActiveRecord::Base
	include Rails.application.routes.url_helpers

  belongs_to :post
  belongs_to :user
  has_many :notification, dependent: :destroy

  #validations
  validates :content, presence: true
  # validates_uniqueness_of :content, scope: [:post_id, :user_id], message: "不能重复提交"

  after_create do
    Comment.send_comment_notification self
  end

  def self.send_comment_notification comment

  	return if comment.blank?
  	@post = comment.post
  	return if @post.blank?

  	# 给post作者发通知
  	# binding.pry
  	if comment.user_id != @post.user_id
  	  Notification.create(user_id: @post.user_id, comment_id: comment.id)
  	end

  	#给关联人发通知
  	# topic.follower_ids.each do |uid|
  	#   next if notified_user_ids.include?(uid)

  	#   next if uid == reply.user_id
  	#   puts "Post Notification to: #{uid}"
  	#   Notification.create user_id: uid, reply_id: reply.id
  	# end
  end


end
