class GoalsController < ApplicationController
  before_action :find_user, only: %i[new create index show destroy update find_journal]
  before_action :find_journal, only: %i[new create index show destroy update find_entry]
  before_action :find_entry, only: %i[show destroy update]
  before_action :require_login
  load_and_authorize_resource


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
