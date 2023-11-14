class UsersController < ApplicationController
  before_action :find_user, only: %i[show destroy update edit]
  before_action :require_login, except: %i[index new create upload_profile_picture confirm_email]
  load_and_authorize_resource

  def create
    @user = User.new(user_params)
    @user.confirm_token = @user.confirmation_token
    if @user.save
      UserMailer.registration_confirmation(@user).deliver
      flash[:success] = t('mailer.please_confirm')
      redirect_to new_user_session_path
    else
      flash[:error] = t('user.message.error.create')
      redirect_to new_user_path
    end
  end

  def update
    if @user.update(user_params)
      flash[:success] = t('user.message.success.update')
      redirect_to user_path(@user)
    else
      flash[:error] = t('user.message.error.update')
      redirect_to edit_user_path(@user)
    end
  end

  def upload_profile_picture
    if params[:user][:profile_picture].present?
      current_user = User.find_by(id: session[:user_id])
      if current_user
        @user = current_user
        @user.profile_picture.attach(params[:user][:profile_picture])
        render json: { message: 'upload.success' }
      else
        render json: { error: 'upload.no_user' }, status: :not_found
      end
    else
      render json: { error: 'upload.invalid' }, status: :unprocessable_entity
    end
    redirect_to user_path(@user)
  end

  def change_role
    if @user.update(user_params[:role])
      flash[:success] = 'a'
    else
      flash[:error] = t('mailer.welcome')
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t('user.message.success.delete')
    else
      flash[:error] = t('user.message.error.delete')
    end
    if current_user.admin?
      redirect_to users_path
    else
      redirect_to new_user_path
    end
  end

  def confirm_email
    @user = User.find_by(confirm_token: params[:confirm_token])
    if @user
      @user.email_activate
      flash[:success] = t('mailer.welcome')
    else
      flash[:error] = t('mailer.not_found')
    end
    redirect_to new_user_session_path
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username,
                                 :first_name,
                                 :last_name,
                                 :password,
                                 :password_confirmation,
                                 :description,
                                 :email,
                                 :mobile,
                                 :adress,
                                 :country,
                                 :city,
                                 :date_of_birth,
                                 :profile_picture,
                                 :role)
  end
end
