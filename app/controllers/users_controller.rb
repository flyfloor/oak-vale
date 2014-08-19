class UsersController < ApplicationController

	before_filter :sign_in_user, only: [:edit, :update]
	before_filter :find_user, only: [:show, :edit, :update, :following, :followers, :favorites]
	before_filter :correct_user, only: [:edit, :update]

	def new
		if signed_in?
			redirect_to root_path
		end
		@user = User.new
	end

	def create
		@user = User.new(user_params)

		if @user.save
			flash[:success] = "欢迎来到Oak Vale!"
			sign_in_permanent @user
			redirect_to @user
		else
			render 'new'
		end
	end

	def update
		if @user.update_attributes(update_user_params)
			flash[:success] = "个人信息已更新！"
      sign_in_permanent @user
      redirect_to @user
		else
		  render 'edit'
		end
	end

	def edit

	end

	def show
		@recent_posts = @user.recent_posts
		@last_likes =  @user.likes_feed(5)
	end

	def favorites
		@like_items = @user.likes_feed
	end

	def following
		@users = @user.followed_users.paginate(user_paginate_opt)
		render 'follow_list'
	end

	def followers
		@users = @user.followers.paginate(user_paginate_opt)
		render 'follow_list'
	end

	private
		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end

		def update_user_params
			params.require(:user).permit(:name, :email)
		end

		def find_user
			@user = User.find(params[:id])
		end

		def correct_user
			redirect_to root_path, notice: "Forbidden" unless current_user? find_user
		end

end
