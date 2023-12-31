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
    context 'with valid user credentials and email confirmation' do
      let(:user) { FactoryBot.create(:user, email_confirmed: true) }

      it 'logs in the user and redirects to the user profile' do
        post :create, params: { user: { username: user.username, password: user.password } }
        expect(session[:user_id]).to eq(user.id)
        expect(flash[:success]).to eq(I18n.t('user_session.message.success.create'))
        expect(response).to redirect_to(user_path(user))
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the session and redirects to the root page' do
      sign_in_as!(user)
      delete :destroy
      expect(session[:user_id]).to be_nil
      expect(response).to redirect_to new_user_path
    end
  end
end
