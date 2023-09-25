#I deactivated the controller funtion #require_login to do the tests more easily

require 'rails_helper'

RSpec.describe UserSessionsController, type: :controller do
  let(:user) do
    FactoryBot.create(:user, username: 'test', password: 'password123', password_confirmation: 'password123')
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    it 'creates a session and redirects to the user profile' do
      post :create, params: { user: { username: user.username, password: 'password123' } }
      expect(session[:user_id]).to eq(user.id)
      expect(response).to redirect_to user_path(user)
    end

    it 'displays an error message and redirects to the login page' do
      post :create, params: { user: { username: user.username, password: 'wrongpassword' } }
      expect(session[:user_id]).to be_nil
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the session and redirects to the root page' do
      session[:user_id] = user.id
      delete :destroy
      expect(session[:user_id]).to be_nil
      expect(response).to redirect_to new_user_path
    end
  end
end
