class TagsController < ApplicationController

	before_filter :sign_in_user, only: [:like, :edit, :update, :create, :destroy]
	before_filter :find_tag, only: [:show, :edit, :destroy, :update]

	def index
		@tags = Tag.all.limit(20)
	end

	def show
		@posts = @tag.posts
	end

	def new
		@tag = Tag.new
	end

	def create
		@tag = Tag.new(tag_params)

		if @tag.save
			flash[:success] = "Tag created"
			redirect_to @tag
		else
			render 'new'
		end
	end

	def edit
		
	end

	def update
		if @tag.update_attributes(tag_params)
			flash[:success] = "Tag updated"
      redirect_to @tag
		else
		  render 'edit'
		end
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
		def tag_params
			params.require(:tag).permit(:name, :avatar)
		end

		def find_tag
			@tag = Tag.find(params[:id])
		end
end
