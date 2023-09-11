class UsersController < ApplicationController

  def index
    @users = User.all
    redirect_to journals_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = t('user.message.success.create')
      redirect_to user_path(@user) 
    else
      flash[:error] = t('user.message.error.create')
      redirect_to user_path(@user) 
    end
  end

  def update
    @user = User.find(params[:id]) 
    if User.update(user_params)
      flash[:success] = t('user.message.success.update')
      redirect_to user_path(@user)
    else
      flash[:error] = t('user.message.error.update')
      redirect_to user_path(@user)
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:success] = t('user.message.success.delete')
      redirect_to new_user_path
    else
      flash[:error] = t('user.message.error.delete')
      redirect_to new_user_path
  end

  def show
    if User.find(params[:id])
    else
      flash[:error] = t('user.message.error.show')
  end

  private
  def user_params
    params.require(:user).permit(:username,
                                 :first_name,
                                 :last_name,
                                 :role,
                                 :country,
                                 :city,
                                 :description,
                                 :date_of_birth,
                                 :joining_date)
    .tap { |whitelisted| whitelisted[:role] = params[:user][:role].to_i }
  end 
end
