class ApplicationController < ActionController::Base
	helper_method :current_user
  helper_method :authenticate_user

  def current_user
    @current_user ||= session[:user_id] && User.find_by(id: session[:user_id])
  end

  def require_login
    user_id = params[:id].to_i
    unless current_user == @user
      flash[:error] = "You must be logged in to access this page."
      session[:user_id] = nil
      redirect_to root_path
    end
  end
end
