class JournalsController < ApplicationController
  before_action :find_user, only: %i[new create index show destroy update]
  before_action :find_journal, only: %i[show destroy update find_journal]
  before_action :require_login
  load_and_authorize_resource

  def index
    @journals = Journal.order(params[:sort])
  end

  def new
    @journal = @user.journals.new
  end

  def create
    @journal = @user.journals.new(journal_params)
    if @journal.save
      flash[:success] = t('journal.message.success.create')
    else
      flash[:error] = t('journal.message.error.create')
    end
    redirect_to user_journals_path(@user)
  end

  def destroy
    if @journal.destroy
      flash[:success] = t('journal.message.success.delete')
    else
      flash[:error] = t('journal.message.error.delete')
    end
    redirect_to user_journals_path
  end

  private

  def find_journal
    @journal = @user.journals.find(params[:id])
  end

  def find_user
    @user = User.find(params[:user_id])
  end

  def journal_params
    params.require(:journal).permit(:title, :description)
  end
end
