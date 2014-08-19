class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :tags
  has_many :like_posts, foreign_key: "post_id", dependent: :destroy, class_name: "UserWithPost"

  validates :title, presence: true
  validates :content, presence: true
  validates :photo, presence: true
  mount_uploader :photo, GalleryUploader
  scope :timeline, -> {order(created_at: :desc)}
  before_save {like_count = 0}


  def self.from_followed_by user
    followed_user_ids = "SELECT followed_id FROM relationships
                     WHERE follower_id = :user_id"
  	where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", user_id: user.id).timeline
  end

  def self.liked_by user
    post_ids = "SELECT post_id FROM user_with_posts
                     WHERE user_id = :user_id"
    where("id IN (#{post_ids})", user_id: user.id).timeline
  end

  def self.hot
    order("like_count").limit(20).timeline
  end
  
end
