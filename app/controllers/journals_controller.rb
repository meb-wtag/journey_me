class JournalsController < ApplicationController
  def index
    @journals = Journal.order(params[:sort])
  end

  def new
    @journal = Journal.new
  end

  def create
    @journal = Journal.new(journal_params)
    if @journal.save
      flash[:success] = t('journal.message.success.create')
      redirect_to journals_path
    else
      flash[:error] = t('journal.message.error.create')
      redirect_to journals_path
    end
  end

  def destroy
    @journal = Journal.find(params[:id])
     if @journal.destroy
      flash[:success] = t('journal.message.success.delete')
      redirect_to journals_path
    else
      flash[:error] = t('journal.message.error.delete')
      redirect_to journals_path
    end
  end

  def show
    @journal = Journal.find(params[:id])
  end

  private
  def journal_params
    params.require(:journal).permit(:title, :description)
  end
end
