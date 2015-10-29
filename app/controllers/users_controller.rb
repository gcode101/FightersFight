class UsersController < ApplicationController

	before_action :set_user, only: [:show, :edit, :update, :destroy]
	before_filter :save_login_state, :only => [:new, :create]
	before_action :authenticate_user, :only => [:edit]

	def index
		@users = User.all
	end

	def new
		@user = User.new
	end

	def show
		@user = User.find(params[:id])
		@post = Post.new
	end

	def edit
	end

	def create
		@user = User.new(user_params)
		respond_to do |format|
			if @user.save
				format.html { 
					session[:id] = @user.id
					redirect_to @user, notice: 'User was succesfully created. ' 
				}
				format.json { 
					session[:id] = @user.id
					render :show, status: :create, location: @user 
				}
			else
				format.html { render :new }
				format.json { render json: @user.errors, status: :unproccessable_entity }
			end
		end
	end

	def update
		respond_to do |format|
			if @user.update(user_params)
				format.html { redirect_to @user, notice: 'User was successfully updated.' }
				format.json { render :show, status: :ok, location: @user }
			else
				format.html { render :edit }
				format.json { render json: @user.errors, status: :unproccessable_entity }
			end
		end
	end

	def destroy 
		@user.destroy
		respond_to do |format|
			format.html { 
				session[:id] = nil
				redirect_to root_path, alert: 'Your account was successfully deleted.' }
			format.json {
			session[:id] = nil
			 head :no_content }
		end
	end

	private
	def set_user
      @user = User.find(params[:id])
    end

	def user_params
		params.require(:user).permit( :fullname, :description, :picture, :username, :password, :email )
	end


end
