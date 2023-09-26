class TasksController < ApplicationController
  before_action :find_user, only: %i[new create index show destroy update find_journal]
  before_action :require_login

  def index
    @tasks = Task.all
  end

  def new
    @task = @user.tasks.new
  end

  def create
    @task = @user.tasks.new(task_params)
    if @journal_entry.save
      flash[:success] = t('entry.message.success.create')
      redirect_to user_journal_path(@user, @journal)
    else
      flash[:error] = t('entry.message.error.create')
      render :new
    end
  end

  def destroy
    if @task.destroy
      flash[:success] = t('entry.message.success.delete')
    else
      flash[:error] = t('entry.message.error.delete')
    end
    redirect_to user_tasks_path
  end

  def update
    if @task.update(task_params)
      flash[:success] = t('entry.message.success.update')
    else
      flash[:error] = t('entry.message.error.update')
    end
    redirect_to user_tasks_path
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end

  def task_params
    params.require(:task).permit(:title,
                                 :description)
  end
end
