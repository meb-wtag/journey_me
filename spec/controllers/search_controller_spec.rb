require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  let(:user) { create(:user) }
  let(:journal) { create(:journal, user: user) }

  describe 'GET #set_query' do
    context 'when user and journal are found' do
      it 'redirects to user journal path' do
        get :set_query, params: { user_id: user.id, journal_id: journal.id, q: { title_cont: 'search_term' } }
        expect(response).to redirect_to(user_journal_path(user, journal))
      end

      it 'assigns the correct variables' do
        get :set_query, params: { user_id: user.id, journal_id: journal.id, q: { title_cont: 'search_term' } }
        expect(assigns(:user)).to eq(user)
        expect(assigns(:journal)).to eq(journal)
        expect(assigns(:entryQuery)).to be_a(Ransack::Search)
        expect(assigns(:entries)).to be_a(ActiveRecord::Relation)
      end
    end

    context 'when user is not found' do
      it 'raises ActiveRecord::RecordNotFound' do
        expect {
          get :set_query, params: { user_id: 'nonexistent', journal_id: journal.id, q: { title_cont: 'search_term' } }
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when journal is not found' do
      it 'raises ActiveRecord::RecordNotFound' do
        expect {
          get :set_query, params: { user_id: user.id, journal_id: 'nonexistent', q: { title_cont: 'search_term' } }
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
