class ApplicationController < ActionController::Base
	helper_method :current_user
  helper_method :authenticate_user
  #before_action :require_login, except: [:new, :create]

  def current_user
    @current_user ||= session[:user_id] && User.find_by(id: session[:user_id])
  end

  def authenticate_user
    unless current_user == current_session_user
      redirect_to root_path
    end
  end

  def require_login
    unless current_user
      flash[:error] = "You must be logged in to access this page."
      redirect_to new_user_path
    end
  end
end
