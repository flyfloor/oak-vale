class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :tags

  #been like by user
  has_many :like_posts, foreign_key: "post_id", dependent: :destroy, class_name: "UserWithPost"

  #validations
  validates :title, presence: true
  validates :content, presence: true
  validates :photo, presence: true

  #photo uploader
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
    order("like_count DESC").limit(20)
  end

  def has_pre?
    user_posts.first != self
  end

  def pre_post
    post_id = self.id
    user_posts.where(" id < ?", post_id).last
  end

  def has_next?
    user_posts.last != self
  end

  def next_post
    post_id = self.id
    user_posts.where(" id > ?", post_id).first
  end

  private

    def user_posts
      self.user.posts
    end
    
end
