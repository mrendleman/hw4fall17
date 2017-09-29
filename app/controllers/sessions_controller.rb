class SessionsController < ApplicationController

  def session_params
    params.require(:user).permit(:user_id, :email)
  end


  def new
    # default: render 'new' template
  end

  def create
    if User.exists?(user_id: session_params[:user_id]) && 
            User.find_by(user_id: session_params[:user_id]).email == session_params[:email]
      user = User.find_by(user_id: session_params[:user_id])
      session[:session_token] = user.session_token
      redirect_to movies_path
    else
      flash[:notice] = "Invalid user-id/email combination."
      redirect_to login_path
    end
  end

  def destroy
    session[:session_token] = nil;
    redirect_to movies_path
  end

end
