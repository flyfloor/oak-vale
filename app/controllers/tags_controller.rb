class TagsController < ApplicationController

	before_filter :sign_in_user, only: [:like]
	before_filter :find_tag, only: [:show]

	def index
		@tags = Tag.all.limit(20)
	end

	def show
		@feed = @tag.posts.paginate(page: params[:page], per_page: 10)
	end

	def subscribe
		@tag = Tag.find(params[:id])

		if current_user.subscribe? @tag
			@tag.subscriber_count -= 1 unless @tag.subscriber_count == 0
			current_user.unsubscribe! @tag
		else
			@tag.subscriber_count += 1
			current_user.subscribe! @tag
		end
		@tag.save
		
		respond_to do |format|
			format.html {redirect_to @tag}
			format.js
		end
	end

	private
		def find_tag
			@tag = Tag.find(params[:id])
		end
end
