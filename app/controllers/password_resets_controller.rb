class PasswordResetsController < ApplicationController
	before_filter :find_by_rest_token, only: [:edit, :update]

  def new

  end

  def create
    @user = User.find_by(email: params[:email])
    if @user
    	@user.send_password_reset 
    	redirect_to root_url, :notice => "Email sent with password reset."
    else
    	flash[:error] = "Email not valid"
    	render 'new'
    end
  end

  def edit
  end

  def update
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, notice: "Password reset has expired."
    elsif @user.update_attributes(reset_params)
      redirect_to root_url, :notice => "Password has been reset!"
    else
      render :edit
    end
  end

  private
  	def find_by_rest_token
 	  	@user = User.find_by!(password_reset_token: params[:id])
  	end

  	def reset_params
  		params.require(:user).permit(:password, :password_confirmation)
  	end

end
