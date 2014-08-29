class Topic < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  scope :timeline, -> {order(created_at: :desc)}

  def self.hot
    order("like_count DESC")
  end
end
