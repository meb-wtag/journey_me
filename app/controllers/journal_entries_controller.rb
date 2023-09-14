class JournalEntriesController < ApplicationController
  before_action :find_journal, only: %i[new create index show destroy update]
  before_action :find_entry, only: %i[show destroy update]
  before_action :require_login

  def index
    @journal_entries = JournalEntry.all
    redirect_to journal_path(@journal)
  end

  def new
    @journal_entry = @journal.journal_entries.new
  end

  def create
    @journal_entry = @journal.journal_entries.new(journal_entry_params)
    if @journal_entry.save
      flash[:success] = t('entry.message.success.create')
      redirect_to journal_path(@journal)
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
    redirect_to journal_path(@journal)
  end

  def show; end

  def update
    if @journal_entry.update(journal_entry_params)
      flash[:success] = t('entry.message.success.update')
    else
      flash[:error] = t('entry.message.error.update')
    end
    redirect_to journal_path(@journal)
  end

  private

  def find_journal
    @journal = Journal.find(params[:journal_id])
  end

  def find_entry
    @journal_entry = @journal.journal_entries.find(params[:id])
  end

  def journal_entry_params
    params.require(:journal_entry).permit(:title,
                                          :content)
  end
end
