class SearchController < ApplicationController
	def index
		@journalQuery = current_user.journals.ransack(params[:q])
		@journals = @journalQuery.result(distinct: true)
	end
end
