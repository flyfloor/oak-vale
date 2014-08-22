class Tag < ActiveRecord::Base
  has_and_belongs_to_many :posts

  #tag with subscribers
  has_many :subscriptions, foreign_key: "tag_id", dependent: :destroy
  has_many :users, through: :subscriptions

  #tag avatar uploader
  mount_uploader :avatar, AvatarUploader
  scope :timeline, -> {order(created_at: :desc)}


  def self.hot
  end

  def self.subscribed_by user
    post_ids = "SELECT tag_id FROM user_with_posts
                     WHERE user_id = :user_id"
    where("id IN (#{post_ids})", user_id: user.id).timeline
  end

end
