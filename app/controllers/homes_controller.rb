class HomesController < ApplicationController
  
  before_filter :authenticate_user, :except => [:index, :login, :login_attempt, :logout]
  before_filter :save_login_state, :only => [:index, :login, :login_attempt]

  def index
  end

  def login_attempt
  	authorized_user = User.authenticate(params[:username_or_email], params[:login_password])
  	if authorized_user
  		session[:id] = authorized_user.id
      @user = User.find(session[:id])
  		redirect_to user_path(@user), notice: "Welcome, you're logged in as #{authorized_user.username}"
  	else
  		redirect_to root_path, notice: "Invalid Username or Password"
  	end
  end

  def logout
  	session[:id] = nil
  	#flash[:notice] = 'You have just logged out.'
  	redirect_to root_path, notice: "You have just logged out."
  end
end
