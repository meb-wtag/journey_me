class SearchController < ApplicationController
	before_action :find_user, only: %i[set_query]
  before_action :find_journal, only: %i[set_query]

	def set_query
    @entryQuery = @journal.journal_entries.ransack(params[:q])
    @entries = @entryQuery.result(distinct: true)
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
