class Topic < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  has_many :replies

  #voted by user
  has_many :vote_topics, foreign_key: "topic_id", dependent: :destroy
  
  scope :timeline, -> {order(created_at: :desc)}


  def self.hot
  	order("like_count DESC")
  end

end
