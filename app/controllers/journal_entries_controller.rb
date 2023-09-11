class JournalEntriesController < ApplicationController

  def index
    @journal = Journal.find(params[:journal_id])
    @journal_entries = JournalEntry.all
    redirect_to journal_path(@journal)
  end
  
  def new
    @journal = Journal.find(params[:journal_id])
    @journal_entry = @journal.journal_entries.new
  end

  def create
    @journal = Journal.find(params[:journal_id])
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
    @journal = Journal.find(params[:journal_id])
    @journal_entry = @journal.journal_entries.find(params[:id])
    if @journal_entry.destroy
      flash[:success] = t('entry.message.success.delete')
      redirect_to journal_path(@journal)
    else
      flash[:error] = t('entry.message.error.delete')
      redirect_to journal_path(@journal)
    end
  end

  def show
    @journal = Journal.find(params[:journal_id])
    @journal_entry = @journal.journal_entries.find(params[:id])
  end

  def update
    @journal = Journal.find(params[:journal_id])
    @journal_entry = @journal.journal_entries.find(params[:id])
    if @journal_entry.update(journal_entry_params)
      flash[:success] = t('entry.message.success.update')
      redirect_to journal_path(@journal)
    else
      flash[:error] = t('entry.message.error.update')
      redirect_to journal_path(@journal) 
    end
  end

  private
  
  def journal_entry_params
    params.require(:journal_entry).permit(:title, 
                                          :content)
  end
end
