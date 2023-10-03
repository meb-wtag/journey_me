class UserSessionsController < ApplicationController
  before_action :require_login, except: %i[new create destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(username: params[:user][:username])

    if @user&.authenticate(params[:user][:password])
      if @user.email_confirmed
        session[:user_id] = @user.id
        flash[:success] = t('user_session.message.success.create')
        redirect_to user_path(@user)
      else
        flash[:error] = t('mail_conf.please_confirm')
      end
    else
      flash[:error] = t('user_session.message.error.create')
      redirect_to new_user_session_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = t('user_session.message.success.delete')
    redirect_to new_user_path
  end
end
