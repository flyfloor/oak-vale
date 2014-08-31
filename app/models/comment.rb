class Comment < ActiveRecord::Base
	include Rails.application.routes.url_helpers

  belongs_to :post
  belongs_to :user
  has_many :notification, dependent: :destroy

  #validations
  validates :content, presence: true
  # validates_uniqueness_of :content, scope: [:post_id, :user_id], message: "不能重复提交"

  before_save do
    self.content_html = self.content.clone

    names = Comment.mentioned_users self
    names.each do |name|
      user = User.find_by(name: name)
      self.content_html.sub!(name, '<a href="'+"#{user_path(user)}"+'">'+"#{user.name}"+'</a>')
    end
  end

  after_create do
    Comment.send_comment_notification self
  end

  def self.send_comment_notification comment

    Comment.sent_to_post_user comment

    Comment.sent_to_mentioned_users comment

  end

  private

    # send notification to related user
    def self.sent_to_mentioned_users comment
      Comment.comment_post_exist? comment
     
      names = Comment.mentioned_users comment

      if names.any?
        ids = User.where(name: names).limit(5).map(&:id).to_a

        ids.each do |uid|
          next if uid.equal? @post.id
          Notification.create(user_id: uid, comment_id: comment.id) 
        end
      end
    end

    # send notification to post user
    def self.sent_to_post_user comment
      Comment.comment_post_exist? comment
      if comment.user_id != @post.user_id
        Notification.create(user_id: @post.user_id, comment_id: comment.id)
      end
    end

    def self.comment_post_exist? comment
      return if comment.blank?
      @post = comment.post
      return if @post.blank?      
    end

    def self.mentioned_users comment
      comment.content.to_s.scan(/@(\w{3,20})/).flatten
    end

end
