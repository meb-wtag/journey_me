require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  let(:user) { FactoryBot.create(:user, role: :admin) }
  let(:journal) { FactoryBot.create(:journal, user: user) }
  let(:entry) { FactoryBot.create(:journal_entry, journal: journal) }

  describe 'GET #set_query' do
    context 'when user and journal are found' do
      it 'redirects to user journal path' do
        get :set_query, params: { user_id: user.id, journal_id: journal.id, q: { title_cont: entry.title } }
        expect(response).to redirect_to(user_journal_path(user, journal))
      end
    end

    context 'when journal is not found' do
      it 'raises ActiveRecord::RecordNotFound' do
        expect {
          get :set_query, params: { user_id: user.id, journal_id: journal.id, q: { title_cont: 'search_term' } }
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
