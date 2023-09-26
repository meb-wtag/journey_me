class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :authenticate_user

  def current_user
    @current_user ||= session[:user_id] && User.find_by(id: session[:user_id])
  end

  def require_login
    if current_user
      if current_user.role == 'admin' || current_user == @user
        return
      else
        redirect_to user_path(current_user)
      end
    else
      session[:user_id] = nil
      redirect_to new_user_path
    end
  end
end
