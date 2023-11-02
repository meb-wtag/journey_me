class SearchController < ApplicationController
	def index
		@journalEntryQuery = @journal.journal_entries.ransack(params[:q])
		@entries = @journalEntryQuery.result(distinct: true)
	end
end
