class JournalEntriesController < ApplicationController
  before_action :find_user, only: %i[new create index show destroy update find_journal]
  before_action :find_journal, only: %i[new create index show destroy update find_entry]
  before_action :find_entry, only: %i[show destroy update]
  before_action :require_login
  load_and_authorize_resource

  def index
    @journal_entries = @journal.journal_entries
    redirect_to user_journal_path(@user, @journal)
  end

  def create
    @journal_entry = @journal.journal_entries.new(journal_entry_params)
    if @journal_entry.save
      flash[:success] = t('entry.message.success.create')
      redirect_to user_journal_path(@user, @journal)
    else
      flash[:error] = t('entry.message.error.create')
      render :new
    end
  end

  def destroy
    if @journal_entry.destroy
      flash[:success] = t('entry.message.success.delete')
    else
      flash[:error] = t('entry.message.error.delete')
    end
    redirect_to user_journal_path(@user, @journal)
  end

  def update
    if @journal_entry.update(journal_entry_params)
      flash[:success] = t('entry.message.success.update')
    else
      flash[:error] = t('entry.message.error.update')
    end
    redirect_to user_journal_path(@user, @journal)
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

  def journal_entry_params
    params.require(:journal_entry).permit(:title,
                                          :content)
  end
end
