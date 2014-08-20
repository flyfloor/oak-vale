class SubscriptionsController < ApplicationController

	before_filter :sign_in_user

	def create
		@tag = User.find(params[:subscription][:tag_id])
      current_user.subscribe!(@tag)
      respond_to do |format|
      	format.html {redirect_to @tag}
      	format.js
      end
	end

	def destroy
    @tag = Subscription.find(params[:id]).tag
    current_user.unsubscribe!(@tag)
    respond_to do |format|
      format.html { redirect_to @tag }
      format.js
    end
	end

end
