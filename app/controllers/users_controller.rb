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
      redirect_to user_path(@user) 
    end
  end

  def edit
    @user = User.find(params[:id]) 
  end

  def update
    @user = User.find(params[:id]) 
    @user = User.update(user_params)
    redirect_to user_path(@user)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to new_user_path
  end

  def show
    @user = User.find(params[:id])
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
