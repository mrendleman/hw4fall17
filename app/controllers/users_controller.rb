class UsersController < ApplicationController

  def user_params
    params.require(:user).permit(:user_id, :email, :session_token)
  end

  def show
    id = params[:id] # retrieve user ID from URI route
    @movie = User.find(id) # look up user by unique ID
    # will render app/views/users/show.<extension> by default
  end

  def index
    @users = User.all
  end

  def new
    # default: render 'new' template
  end

  def create
    if User.exists?(user_id: user_params[:user_id]) 
      flash[:notice] = "Sorry, this user-ID is taken. Try another."
      redirect_to new_user_path
    else
      @user = User.create_user!(user_params)
      flash[:notice] = "Welcome, #{user_params[:user_id]}. Your account has been created."
      redirect_to login_path
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
