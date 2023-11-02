class SearchController < ApplicationController
	before_action :find_user, only: %i[index]
  before_action :find_journal, only: %i[index]
	def index
		@journalEntryQuery = @journal.journal_entries.ransack(params[:q])
		@entries = @journalEntryQuery.result(distinct: true)
		redirect_to user_journal_path(@user, @journal)
	end

	private

	def find_user
	  @user = User.find(params[:user_id])
	end

	def find_journal
	  @journal = @user.journals.find(params[:journal_id])
	end
end
