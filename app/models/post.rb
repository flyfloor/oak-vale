class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :tags
  validates :title, presence: true
  validates :content, presence: true
  validates :photo, presence: true
  mount_uploader :photo, GalleryUploader
  scope :timeline, -> {order(created_at: :desc)}


  def self.from_followed_by user
    followed_user_ids = "SELECT followed_id FROM relationships
                     WHERE follower_id = :user_id"
  	where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", user_id: user.id).timeline
  end
  
end
