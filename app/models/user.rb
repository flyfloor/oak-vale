class User < ActiveRecord::Base
	has_secure_password
	has_many :posts
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :followers, through: :reverse_relationships, source: :follower

	validates :name, presence: true, uniqueness: true, length: {in: 5..30}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: {with: VALID_EMAIL_REGEX }

  validates :password, presence: true, length: {in: 6..20}, on: :create
  validates :password_confirmation, presence: true, on: :create

  before_save {|user| user.email = email.downcase}
  before_create {create_token(:remember_token)}


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

  def following? other_user
    relationships.find_by(followed_id: other_user.id)
  end

  def follow! other_user
    relationships.create!(followed_id: other_user.id)
  end


  def unfollow! other_user
    relationships.find_by(followed_id: other_user.id).destroy
  end

end
