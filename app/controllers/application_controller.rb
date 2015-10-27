class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected
  def authenticate_user
  	unless session[:id]
  		redirect_to login_path
  		return false
  	else
  		@current_user = User.find session[:id]
  		return true
  	end
  end
    #This method is to prevent user to access Signup & Login Page without logout
  def save_login_state
  	if session[:id]
      @user = User.find(session[:id])
  		redirect_to user_path(@user)
  		return false
  	else
  		return true
  	end
  end
end
