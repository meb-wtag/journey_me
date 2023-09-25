class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :authenticate_user

  def current_user
    @current_user ||= session[:user_id] && User.find_by(id: session[:user_id])
  end

  def require_login
    return if current_user
    
    flash[:error] = t('login.required')
    session[:user_id] = nil
    redirect_to root_path
  end
end
