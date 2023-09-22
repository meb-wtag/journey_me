require 'rails_helper'
RSpec.describe JournalEntriesController, type: :controller do
  let!(:user) { FactoryBot.create(:user) }
  let!(:journal) { FactoryBot.create(:journal, user:) }
  let!(:entry) { FactoryBot.create(:journal_entry, journal:) }
  let!(:valid_params) { FactoryBot.attributes_for(:journal_entry) }

  describe 'GET #index' do
    let(:entry2) { FactoryBot.create(:journal_entry, journal:) }

    it 'populates an array of all journal entries' do
      get :index, params: { user_id: user.id, journal_id: journal.id, journal_entry: valid_params }
      expect(assigns(:journal_entries)).to match_array [entry, entry2]
    end

    it 'redirects to the journals page' do
      get :index, params: { user_id: user.id, journal_id: journal.id }
      expect(response).to redirect_to user_journal_path(user, journal)
    end
  end

  describe 'GET #new' do
    it 'assigns a new Entry to @journal_entry' do
      get :new, params: { user_id: user.id, journal_id: journal.id, journal_entry: valid_params }
      expect(assigns(:journal_entry)).to be_a_new(JournalEntry)
    end

    it 'renders the :new template' do
      get :new, params: { user_id: user.id, journal_id: journal.id, journal_entry: valid_params }
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    it 'creates an Entry with params and saves it' do
      expect do
        post :create, params: { user_id: user.id, journal_id: journal.id, journal_entry: valid_params }
      end.to change(JournalEntry, :count).by(1)
    end

    it 'redirects to journals_path' do
      post :create, params: { user_id: user.id, journal_id: journal.id, journal_entry: valid_params }
      expect(response).to redirect_to user_journal_path(user, journal)
    end
  end

  describe 'GET #show' do
    it 'renders the :show template' do
      get :show, params: { user_id: user.id, journal_id: journal.id, id: entry.id }
      expect(response).to render_template :show
    end
  end

  describe 'POST #update' do
    it 'updates an Entry with params and saves it' do
      expect do
        post :update,
             params: { user_id: user.id, journal_id: journal.id, id: entry.id,
                       journal_entry: { title: 'New Title', content: 'New Content' } }
        entry.reload
      end.to change { entry.title }.to 'New Title'
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the journal' do
      delete :destroy, params: { user_id: user.id, journal_id: journal.id, id: entry.id }
      expect { entry.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'renders the :show template' do
      delete :destroy, params: { user_id: user.id, journal_id: journal.id, id: entry.id }
      expect(response).to redirect_to user_journal_path(user, journal)
    end
  end
end
