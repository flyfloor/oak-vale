class Tag < ActiveRecord::Base
  has_and_belongs_to_many :posts
  # has_many :subscriptions, foreign_key: "tag_id", dependent: :destroy
  # has_many :users, through: :subscriptions

  scope :timeline, -> {order(created_at: :desc)}


  def self.hot
  end

  def self.subscribed_by user
    post_ids = "SELECT post_id FROM user_with_posts
                     WHERE user_id = :user_id"
    where("id IN (#{post_ids})", user_id: user.id).timeline
  end

end
