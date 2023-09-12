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
    else
      flash[:error] = t('journal.message.error.create')
    end
    redirect_to journals_path
  end

  def destroy
    @journal = Journal.find(params[:id])
    if @journal.destroy
      flash[:success] = t('journal.message.success.delete')
    else
      flash[:error] = t('journal.message.error.delete')
    end
    redirect_to journals_path
  end

  def show
    @journal = Journal.find(params[:id])
  end

  private
  def journal_params
    params.require(:journal).permit(:title, :description)
  end
end
  