require 'spec_helper'
require 'rails_helper'
RSpec.describe UsersController, type: :controller do
  let(:admin) do
    FactoryBot.create(:user, role: :admin)
  end

  describe 'GET #new' do
    it 'assigns a new User to @user' do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end

    it 'renders the :new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET #show' do
    it 'displays the requested User to @user' do
      get :show, params: { id: user.id }
      expect(assigns(:user)).to eq user
    end

    it 'renders the :show template' do
      sign_in_as!(user)
      get :show, params: { id: user.id }
      expect(response).to render_template :show
    end
  end

  describe 'DELETE #destroy' do
    let(:user_to_delete) do
      FactoryBot.create(:user)
    end

    it 'deletes the user' do
      expect {
        delete :destroy, params: { id: user_to_delete.id }
      }.to change(User, :count).by(-1)
    end

    it 'redirects to the users path' do
      delete :destroy, params: { id: user_to_delete.id }
      expect(response).to redirect_to(new_user_path)
    end
  end

  describe 'POST #create' do
    context 'with valid user parameters' do
      let(:valid_params) do
        {
          user: {
            username: 'newuser',
            password: 'password',
            password_confirmation: 'password',
            email: 'abc'
          }
        }
      end

      it 'creates a new user' do
        expect do
          post :create, params: valid_params
        end.to change(User, :count).by(1)
      end

      it 'sends a registration confirmation email' do
        expect do
          post :create, params: valid_params
        end.to change { ActionMailer::Base.deliveries.count }.by(1)
      end

      it 'sets a success flash message' do
        post :create, params: valid_params
        expect(flash[:success]).to eq(I18n.t('mailer.please_confirm'))
      end

      it 'redirects to the users profile page' do
        post :create, params: valid_params
        user = User.last
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'with invalid user parameters' do
      let(:invalid_params) do
        {
          user: {
            username: '',
            password: 'password',
            password_confirmation: 'passord'
          }
        }
      end

      it 'does not create a new user' do
        expect do
          post :create, params: invalid_params
        end.not_to change(User, :count)
      end

      it 'sets an error flash message' do
        post :create, params: invalid_params
        expect(flash[:error]).to eq(I18n.t('user.message.error.create'))
      end

      it 'redirects to the new user registration page' do
        post :create, params: invalid_params
        expect(response).to redirect_to(new_user_path)
      end
    end
  end

  describe 'GET #update' do
    let(:user3) do
      FactoryBot.create(:user)
    end

    it 'updates a User with params and saves it' do
      sign_in_as!(user3)
      expect do
        patch :update, params: { id: user3.id, user: { first_name: 'Name123' } }
      end.to change { user3.reload.first_name }.to 'Name123'
    end

    it 'renders the :edit template when succedes' do
      sign_in_as!(user)
      get :update, params: { id: user.id, user: { username: 'test' } }
      expect(response).to redirect_to user_path(user)
    end

    it 'renders the :edit template when fails' do
      sign_in_as!(user)
      get :update, params: { id: user.id, user: { username: nil } }
      expect(response).to redirect_to edit_user_path(user)
    end
  end

  describe 'PATCH #role_change' do
    let!(:user_user) { FactoryBot.create(:user, role: :user) }
    let!(:admin_user) { FactoryBot.create(:user, role: :admin) }
    it 'takes the role from admin and changes it to User' do
      sign_in_as!(user)
      expect do
        patch :change_role, params: { id: user_user.id }
      end.to change { user_user.reload.role }.to 'admin'
    end

    it 'changes the role to Admin' do
      sign_in_as!(user)
      expect do
        patch :change_role, params: { id: admin_user.id }
      end.to change { admin_user.reload.role }.to 'user'
    end
  end

  describe 'GET #confirm_email' do
    let(:user5) do
      FactoryBot.create(:user, confirm_token: 'valid_token')
    end

    context 'with a valid confirmation token' do
      it 'activates the users email' do
        get :confirm_email, params: { id: user5.id, confirm_token: 'valid_token' }
        user5.reload
        expect(user5.email_confirmed).to be true
      end

      it 'redirects to the new user session path' do
        get :confirm_email, params: { id: user5.id, confirm_token: 'valid_token' }
        expect(response).to redirect_to(new_user_session_path)
      end

      it 'sets a success flash message' do
        get :confirm_email, params: { id: user5.id, confirm_token: 'valid_token' }
        expect(flash[:success]).to eq(I18n.t('mailer.welcome'))
      end
    end

    context 'with an invalid confirmation token' do
      it 'redirects to the root URL' do
        get :confirm_email, params: { id: user5.id, confirm_token: 'invalid_token' }
        expect(response).to redirect_to(new_user_session_path)
      end

      it 'sets an error flash message' do
        get :confirm_email, params: { id: user5.id, confirm_token: 'invalid_token' }
        expect(flash[:error]).to eq(I18n.t('mailer.not_found'))
      end
    end
  end
end
