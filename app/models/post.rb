class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :tags
  validates :title, presence: true
  validates :content, presence: true
  validates :photo, presence: true
  mount_uploader :photo, GalleryUploader

  def self.from_followed_by user
  	where("user_id IN (?) OR user_id = ?", user.followed_user_ids, user)
  end
  
end
