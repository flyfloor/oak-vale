class NotificationsController < ApplicationController
	before_filter :sign_in_user
  def index
  	@notifications = current_user.notifications.timeline
  															.paginate(page: params[:page], per_page: 10)
  end

  def clear
  	current_user.notifications.delete_all
    respond_to do |format|
      format.html { redirect_to notifications_path }
      format.js { render layout: false }
    end  
	end
end
