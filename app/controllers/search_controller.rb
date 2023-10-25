class SearchController < ApplicationController
	def index
		@journalQuery = Journal.ransack(params[:q])
		@journals = @journalQuery.result(distinct: true)
		@entryQuery = JournalEntry.ransack(params[:q])
		@entries = @entryQuery.result(distinct: true)
	end
end
