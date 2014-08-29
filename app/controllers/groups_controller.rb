class GroupsController < ApplicationController
	before_filter :sign_in_user, only: [:new, :edit, :update, :create]
	before_filter :find_group, only: [:show, :edit, :update]

	def index
		@groups = Group.all.limit(20)
		@hot_topics = Topic.hot.paginate(page: params[:page], per_page: 30)
	end

	def new
		@group = Group.new
	end

	def show
		@topics = @group.topics.timeline.paginate(page: params[:page], per_page: 50)
		@members = @group.users.timeline.limit(50)
	end

	def update
		if @group.update_attributes(group_params)
			flash[:success] = "Group updated"
      redirect_to @group
		else
		  render 'edit'
		end
	end

	def create
		@group = Group.new(group_params)

		if @group.save
			flash[:success] = "Group created"
			redirect_to @group
		else
			render 'new'
		end
	end

	def join
		@group = Group.find(params[:id])

		if current_user.joined? @group
			@group.members_count -= 1 unless @group.members_count == 0
			current_user.leave! @group
		else
			@group.members_count += 1
			current_user.join! @group
		end
		@group.save
		
		respond_to do |format|
			format.html {redirect_to @group}
			format.js
		end
	end


	private
		def group_params
			params.require(:group).permit(:name, :avatar, :desc)
		end

		def find_group
			@group = Group.find(params[:id])
		end

end
