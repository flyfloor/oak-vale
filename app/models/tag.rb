class Tag < ActiveRecord::Base
  has_and_belongs_to_many :posts
  scope :timeline, -> {order(created_at: :desc)}


  def self.hot
  end

end
