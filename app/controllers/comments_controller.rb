class CommentsController < ApplicationController
	before_filter :sign_in_user, only: [ :create, :destroy]

	def create
		@comment = Comment.new
		if signed_in?
			author_comment @comment
			@comment[:content] = params[:comment][:content]
		else
			@comment = Comment.new(params[:comment])
		end

		thing.comments << @comment
		redirect_to thing
	end

	def destroy
		@comment = thing.comments.find params[:id]
		if @comment.destroy
			render json:{success: true}
		end
	end
	
end
