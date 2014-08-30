class Reply < ActiveRecord::Base
	belongs_to :topic
	belongs_to :user
	
	#validations
	validates :content, presence: true
end
