class UserSessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(username: params[:user][:name])

    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to user_session_path
    else
      flash[:alert] = "Login failed"
      redirect_to user_session_path
    end
  end
end 