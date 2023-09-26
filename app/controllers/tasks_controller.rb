class TasksController < ApplicationController
  before_action :find_user, only: %i[new create index show destroy update find_task]
  before_action :find_task, only: %i[show destroy update]
  before_action :require_login

  def index
    @tasks = Task.all
  end

  def new
    @task = @user.tasks.new
  end

  def create
    @task = @user.tasks.new(task_params)
    @task.user_id = @user.id
    if @task.save
      flash[:success] = t('task.message.success.create')
    else
      flash[:error] = t('task.message.error.create')
      render :new
    end
    redirect_to user_tasks_path(@user)
  end

  def destroy
    if @task.destroy
      flash[:success] = t('task.message.success.delete')
    else
      flash[:error] = t('task.message.error.delete')
    end
    redirect_to user_tasks_path
  end

  def update
    if @task.update(task_params)
      flash[:success] = t('task.message.success.update')
    else
      flash[:error] = t('task.message.error.update')
    end
    redirect_to user_tasks_path
  end

  def show
  end

  private

  def find_task
    @task = @user.tasks.find(params[:id])
  end

    def find_user
    @user = User.find(params[:user_id])
  end

  def task_params
    params.require(:task).permit(:title,
                                 :content)
  end
end
