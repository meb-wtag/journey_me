class JournalEntriesController < ApplicationController

	def index
		@journal_entries = JournalEntry.order(params[:sort])
	end
	
	def new
		@journal = Journal.find(params[:journal_id])
		@journal_entry = @journal.journal_entries.new
	end

	def create
		@journal = Journal.find(params[:journal_id])
		@journal_entry = @journal.journal_entries.new(journal_entry_params)

		if @journal_entry.save
			redirect_to journal_path(@journal), notice: 'Journal entry was successfully created.'
		else
			render :new
		end
	end

	def destroy
		@journal_entry = JournalEntry.find(params[:journal_id])
		@journal_entry.destroy

		redirect_to journal_path
	end

	def show
		@journal_entry = JournalEntry.find(params[:journal_id])
	end

	private
	
	def journal_entry_params
		params.require(:journal_entry).permit(:title, 
			:content,
			:file)
	end
end
