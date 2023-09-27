class TasksController < ApplicationController
  before_action :find_user, only: %i[new create index show destroy update find_task]
  before_action :find_task, only: %i[show destroy update]

  def index
    @tasks = Task.all
    @user_tasks = Assignment.where(user_id: current_user.id).pluck(:task_id)
    @user_tasks = Task.where(id: @user_tasks)
  end

  def new
    @task = @user.tasks.new
    @users = User.all
  end

  def create
    @task = @user.tasks.new(task_params)
    @task.users = User.where(id: params[:task][:user_ids])
    @task.user_id = @user.id
    if @task.save
      flash[:success] = t('task.message.success.create')
    else
      flash[:error] = t('task.message.error.create')
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
    @task.files.attach(params[:task][:files])
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
                                 :description,
                                 :content,
                                 files: [],
                                 user_ids: [])
  end
end
