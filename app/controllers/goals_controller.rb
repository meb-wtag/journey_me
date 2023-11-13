class GoalsController < ApplicationController
  before_action :find_user, only: %i[new create index show destroy update find_journal]
  before_action :find_journal, only: %i[new create index show destroy update find_entry]
  before_action :find_entry, only: %i[show destroy update]
  before_action :require_login
  load_and_authorize_resource

  def index
    @goal = @journal_entry.goals.find(params[:id])
  end

  def shwo
  end

  def new
    @goal = Goal.new
  end

  def create
    @goal = @journal_entry.goals.new(goal_params)
    if @goal.save
      flash[:success] = t('journal.message.success.create')
    else
      flash[:error] = t('journal.message.error.create')
    end
    redirect_to user_journal_journal_entry_path(@user, @journal, @journal_entry)
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end

  def find_journal
    @journal = @user.journals.find(params[:journal_id])
  end

  def find_entry
    @journal_entry = @journal.journal_entries.find(params[:id])
  end

  def goal_params
    params.require(:journal_entry).permit(:title,
                                          :description)
  end
end
