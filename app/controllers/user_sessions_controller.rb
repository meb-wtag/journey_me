class UserSessionsController < ApplicationController
  #before_action :require_login

  def new
    @user = User.new
    redirect_to new_user_path
  end

  def create
    @user = User.find_by(username: params[:user][:username])

    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      flash[:alert] = "Success"
      redirect_to user_path(@user)
    else
      flash[:alert] = "Login failed"
      redirect_to new_user_session_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to new_user_path
  end
end
