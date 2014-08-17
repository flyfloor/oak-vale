class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include ApplicationHelper, SessionsHelper

  def index
    @list = Post.from_followed_by(current_user).paginate(index_paginate_opt) if current_user
  	render 'index'
  end


  def not_found
  	raise ActionController::RoutingError.new('not found')
  end

  private

    def index_paginate_opt
      {page: params[:page], per_page: 30}
    end

end
