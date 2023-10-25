class SearchController < ApplicationController
	def index
		@journalQuery = Journal.ransack(params[:q])
		@journals = @journalQuery.result(distinct: true)
	end
end
