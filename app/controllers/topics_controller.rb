class TopicsController < ApplicationController
	before_filter :find_group, only: [:index, :new, :create, :show, :edit]
	before_filter :find_topic, only: [:show, :edit, :update]
  
  def index
  	@topics = @group.topics.paginate(page: params[:page], per_page: 30)
  end

  def new
  	@topic = @group.topics.new
  end

  def show
    @user = @topic.user
    @replies = @topic.replies.order("created_at DESC").paginate(page: params[:page], per_page: 30)
  end

  def edit
  	
  end

  def create
  	@topic = @group.topics.build(topic_params)
		@topic.user = current_user
		flash[:error] = '评论失败' unless @topic.save

		redirect_to group_topic_path(@topic.group, @topic)
  end

  def update
    if @topic.update_attributes(topic_params)
      flash[:success] = "topic updated"
      redirect_to group_topic_path(@topic.group, @topic)
    else
      render 'edit'
    end
  end




  private
	  def find_group
	  	@group = Group.find(params[:group_id])
	  end

	  def find_topic
	  	@topic = Topic.find(params[:id])
	  end

	  def topic_params
	  	params.require(:topic).permit(:title, :content)
	  end
end
