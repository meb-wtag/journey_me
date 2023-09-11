require 'rails_helper'

RSpec.describe JournalEntriesController, type: :controller do
  let(:journal) do
    FactoryBot.create(:journal)
  end

  let(:entry) do
    FactoryBot.create(:journal_entry, journal: journal)
  end

  let(:valid_params) do
        FactoryBot.attributes_for(:journal_entry)
      end

  describe 'GET #index' do
    let!(:entry_2) do
      FactoryBot.create(:journal_entry, journal: journal, title: 'Test2', content: 'abc', goal: 'abc')
    end

    it 'populates an array of all journal entries' do
      get :index, params: { journal_id: journal.id, journal_entry: valid_params }
      expect(assigns(:journal_entries)).to match_array [entry, entry_2]
    end

    it 'redirects to the journals page' do
      get :index, params: { journal_id: journal.id, journal_entry: valid_params }
      expect(response).to redirect_to journal_path(journal) 
    end
  end

  describe 'GET #new' do 
    it 'assigns a new Entry to @journal_entry' do
      get :new, params: { journal_id: journal.id }
      expect(assigns(:journal_entry)).to be_a_new(JournalEntry)
    end

    it 'renders the :new template' do
      get :new, params: { journal_id: journal.id }
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do 

    it 'creates an Entry with params and saves it' do
      expect do
        post :create, params: { journal_id: journal.id, journal_entry: valid_params }
        end.to change(JournalEntry, :count).by(1)
    end

    it 'redirects to journals_path' do
      post :create, params: { journal_id: journal.id, journal_entry: valid_params }
      expect(response).to redirect_to journal_path(journal)
    end
  end

  describe 'GET #show' do 
    it 'renders the :show template' do
      get :show, params: { journal_id: journal.id, id: entry.id }
      expect(response).to render_template :show
    end
  end

  describe 'POST #update' do

  let(:entry3) do
    FactoryBot.create(:journal_entry, journal: journal)
  end
  
  it 'updates an Entry with params and saves it' do
    expect do     
      post :update, params: { journal_id: journal.id, id: entry3.id, journal_entry: { title: 'New Title', content: 'New Content' } }
      entry3.reload
      end.to change{entry3.title}.to 'New Title'
    end
  end

    describe 'DELETE #destroy' do 
    it 'deletes the journal' do
        delete :destroy, params: { journal_id: journal.id, id: entry.id }
        expect { entry.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'renders the :show template' do
      delete :destroy, params: { journal_id: journal.id, id: entry.id }
      expect(response).to redirect_to journal_path(journal)
    end
  end
end
