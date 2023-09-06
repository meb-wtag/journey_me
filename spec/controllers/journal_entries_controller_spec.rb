require 'rails_helper'

RSpec.describe JournalEntriesController, type: :controller do
  let(:journal) do
    FactoryBot.create(:journal)
  end

  let(:entry_1) do
    FactoryBot.create(:journal_entry, journal: journal)
  end

  # describe 'GET #index' do
  #   let!(:entry_2) do
  #     FactoryBot.create(:journal_entry, journal: journal, title: 'Test2', content: 'abc', goal: 'abc')
  #   end

  #   it 'populates an array of all journal entries' do
  #     get :index
  #     expect(assigns(:journal_entries)).to match_array [entry_1, entry_2]
  # end

  describe 'GET #new' do 
		it 'assigns a new Entry to @journal_entrys' do
			get :new
    	expect(assigns :journal_entry).to be_a_new(JournalEntry)
    end

   	it 'renders the :new template' do
			get :new
    	expect(response).to render_template :new
    end
  end
end
