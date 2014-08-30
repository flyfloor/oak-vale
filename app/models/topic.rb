class Topic < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  has_many :replies
  
  scope :timeline, -> {order(created_at: :desc)}

end
