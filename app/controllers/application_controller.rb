class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  def authenticate_user
  	unless session[:id]
  		redirect_to login_path
  		return false
  	else
  		@current_user = current_user
  		return true
  	end
  end
    #This method is to prevent user to access Signup & Login Page without logout
  def save_login_state
  	if session[:id]
      @user = current_user
  		redirect_to user_path(@user)
  		return false
  	else
  		return true
  	end
  end

  def current_user
    # if @current_user
    #   return @current_user
    # else
    #   @current_user = User.find(session[:id])
    #   return @current_user
    # end

    @current_user ||= User.find session[:id] # @current_user = @current_user || User.find(session[:id]))
  end

  def is_this_me?(user)
    current_user && current_user.id == user.id
  end

  helper_method :current_user, :is_this_me?
end
