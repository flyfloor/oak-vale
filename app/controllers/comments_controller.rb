#coding: utf-8
class CommentsController < ApplicationController
	before_filter :sign_in_user, only: [ :create, :destroy]
	before_filter :find_post, only: [ :create, :destroy]

	def create
		@comment = @post.comments.build(comment_params)
		@comment.user = current_user
		flash[:error] = '评论失败' unless @comment.save

		redirect_to @post

	end

	def destroy
		@comment = @post.comments.find params[:id]
		if @comment.destroy
			redirect_to @post
		end
	end

	private
		def comment_params
			params.require(:comment).permit(:content)
		end

		def find_post
			@post = Post.find params[:post_id]
		end
	
end
