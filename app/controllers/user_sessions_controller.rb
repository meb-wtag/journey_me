class UserSessionsController < ApplicationController

  def new
    @user = User.new
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
    redirect_to root_path
  end

  def current_user
    return nil unless session[:user_id].present?
    @current_user ||= User.find(params[:id])
  end
end
