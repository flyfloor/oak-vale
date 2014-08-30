class RepliesController < ApplicationController
  before_filter :sign_in_user, only: [ :create, :destroy]
  before_filter :find_topic, only: [ :create, :destroy]

  def create
  	@reply = @topic.replies.build(reply_params)
  	@reply.user = current_user
  	flash[:error] = '评论失败' unless @reply.save
 
  	redirect_to group_topic_path(@topic.group, @topic)
  end

  def destroy
  	@reply = @topic.replies.find params[:id]
  	if @reply.destroy
  		redirect_to group_topic_path(@topic.group, @topic)
  	end
  end

  private
  	def reply_params
  		params.require(:reply).permit(:content)
  	end

  	def find_topic
  		@topic = Topic.find params[:topic_id]
  	end
  
end
