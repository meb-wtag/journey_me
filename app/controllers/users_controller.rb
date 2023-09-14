class UsersController < ApplicationController
   before_action :find_user, only: %i[show destroy update]
   before_action :require_login, except: [:new, :create]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = t('user.message.success.create')
      redirect_to user_path(@user)
    else
      flash[:error] = t('user.message.error.create')
      redirect_to new_user_path
    end
  end

  def update
    if User.update(user_params)
      flash[:success] = t('user.message.success.update')
      redirect_to user_path(@user)
    else
      flash[:error] = t('user.message.error.update')
      redirect_to user_path(@user)
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t('user.message.success.delete')
      redirect_to new_user_path
    else
      flash[:error] = t('user.message.error.delete')
      redirect_to new_user_path
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def show;end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username,
                                 :first_name,
                                 :last_name,
                                 :password,
                                 :password_confirmation)
    .tap { |whitelisted| whitelisted[:role] = params[:user][:role].to_i }
  end 
end
