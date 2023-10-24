class SearchController < ApplicationController
	def index
		@query = Journal.ransack(params[:q])
		@journals = @journalQuery.result(distinct: true)
	end
end
