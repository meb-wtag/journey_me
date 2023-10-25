class JournalsController < ApplicationController
  before_action :find_user, only: %i[new create index show destroy update find_journal]
  before_action :find_journal, only: %i[show destroy update calendar]
  before_action :require_login
  load_and_authorize_resource

  def index
    @journals = @user.journals.order(params[:sort])
  end

  def create
    @journal = @user.journals.new(journal_params)
    if @journal.save
      flash[:success] = t('journal.message.success.create')
    else
      flash[:error] = t('journal.message.error.create')
    end
    redirect_to user_journal_path(@user, @journal)
  end

  def destroy
    if @journal.destroy
      flash[:success] = t('journal.message.success.delete')
    else
      flash[:error] = t('journal.message.error.delete')
    end
    redirect_to user_path
  end

  def upload_file
    @user = User.find(params[:user_id])
    @journal = @user.journals.find(params[:id])
    if params[:files].present?
      params[:files].each do |file|
        @journal.files.attach(file)
      end
      render json: { message: t('upload.success') }
    else
      render json: { error: t('upload.no_user') }, status: :not_found
    end
  end

  def delete_file
    @file = @journal.files.find(params[:file_id])
    if @file.purge
      flash[:success] = t('file.delete.success')
    else
      flash[:error] = t('file.delete.fail')
    end
  end

  def calendar
    @events = JournalEntry.all
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end

  def find_journal
    @journal = @user.journals.find(params[:id])
  end

  def journal_params
    params.require(:journal).permit(:title, :description, files: [])
  end
end
