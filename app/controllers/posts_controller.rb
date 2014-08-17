class PostsController < ApplicationController
	before_filter :sign_in_user, except: [:show, :index]
	before_filter :find_post, only: [:show, :edit, :destroy, :update]
	before_filter :correct_post, only: [:edit, :update, :destroy]

	def index
		@posts = post_author.posts.paginate(page: params[:page], per_page: 10)
	end

	def new
		@post = Post.new
	end

	def create
		@post = current_user.posts.build(post_params)
		if @post.save
			flash[:success] = "Post created"
			redirect_back_or @post
		else
			render 'new'
		end
	end

	def update
		if @post.update_attributes(post_params)
			flash[:success] = "Post updated"
      redirect_to @post
		else
		  render 'edit'
		end
	end

	def edit
	end

	def show

	end

	def destroy
		respond_to do |format|
			format.json {
				if your_post?
					if @post.destroy
						render json:{success: true}
					else
						render json:{success: false}
					end
				end
			}

			format.html {
				if @post.destroy
					redirect_to post_author
				end
			}
		end
	end

	private
		def post_params
			params.require(:post).permit(:title, :content, :photo, :user_id)
		end

		def find_post
			@post = Post.find params[:id]
		end

		def post_author
			User.find (params[:user_id] || @post.user_id)
		end

		def your_post?
			current_user? post_author
		end

		def correct_post
			redirect_to root_path, notice: "Forbidden" unless your_post?
		end
end
