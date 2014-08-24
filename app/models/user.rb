class User < ActiveRecord::Base
	has_secure_password
  has_many :posts
  has_many :comments
	has_many :notifications

  #follow relationships
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :followers, through: :reverse_relationships, source: :follower

  #user like post
  has_many :like_posts, foreign_key: "user_id", dependent: :destroy, class_name: "UserWithPost"

  # user subscribe tag
  has_many :subscriptions, foreign_key: "user_id", dependent: :destroy
  has_many :tags, through: :subscriptions

  #validations
	validates :name, presence: true, uniqueness: true, length: {in: 5..30}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: {with: VALID_EMAIL_REGEX }
  validates :password, presence: true, length: {in: 6..20}, on: :create
  validates :password_confirmation, presence: true, on: :create

  before_save {|user| user.email = email.downcase}
  before_create {create_token(:remember_token)}
  scope :timeline, -> {order(created_at: :desc)}

  def feed
    Post.from_followed_by self
  end

  def likes_feed(limit = nil)
    Post.liked_by(self).limit(limit)
  end

  def recent_posts(count = 6)
    self.posts.timeline.limit(count)
  end

  def create_token column
		begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def send_password_reset
    create_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  #relationship
  def following? user
    relationships.find_by(followed_id: user.id)
  end

  def follow! user
    relationships.create!(followed_id: user.id)
  end


  def unfollow! user
    relationships.find_by(followed_id: user.id).destroy
  end

  #like post
  def like? post
    like_posts.find_by(post_id: post.id)    
  end

  def like! post
    like_posts.create!(post_id: post.id)
  end

  def unlike! post
    like_posts.find_by(post_id: post.id).destroy  
  end

  #subscribe
  def subscribe? tag
    subscriptions.find_by(tag_id: tag.id) if self.present?
  end
  
  def subscribe! tag
    subscriptions.create!(tag_id: tag.id)  
  end

  def unsubscribe! tag
    subscriptions.find_by(tag_id: tag.id).destroy
  end

end
