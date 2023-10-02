require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  let(:user) do
    FactoryBot.create(:user, role: 'admin')
  end

  describe 'GET #current_user' do
    it 'renders the new template' do
    	log_in_as!(user)
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET #require_user' do
    it 'creates a session and redirects to the user profile' do
      get :require_login, params: { user: { username: user.username, password: 'password123' } }
      expect(session[:user_id]).to eq(user.id)
      expect(response).to redirect_to user_path(user)
    end
  end
end
