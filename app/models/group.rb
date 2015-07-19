class Group < ActiveRecord::Base

  has_many :group_userships, foreign_key: "group_id", dependent: :destroy
  has_many :users, through: :group_userships
  has_many :topics

  #tag avatar uploader
  mount_uploader :avatar, AvatarUploader
  
  scope :timeline, -> {order(created_at: :desc)}
end
