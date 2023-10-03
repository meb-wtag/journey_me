require 'rails_helper'

RSpec.describe UserSessionsController, type: :controller do
  let!(:user) do
    FactoryBot.create(:user)
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    it 'creates a session and redirects to the user profile' do
      post :create, params: { user: { username: user.username, password: user.password } }
      expect(session[:user_id]).to eq(user.id)
      expect(response).to redirect_to user_path(user)
    end

    it 'displays an error message and redirects to the login page' do
      post :create, params: { user: { username: user.username, password: 'wrong_pw' } }
      expect(session[:user_id]).to be_nil
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the session and redirects to the root page' do
      sign_in_as!(user)
      delete :destroy
      expect(session[:user_id]).to be_nil
      expect(response).to redirect_to root_path
    end
  end
end
