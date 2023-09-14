class UserSessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(username: params[:user][:username])

    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      flash[:alert] = "Success"
      redirect_to user_path(current_user)
    else
      flash[:alert] = "Login failed"
      redirect_to new_user_path
    end
  end
end

def current_user
  @current_user ||= User.find(params[:id])
end

