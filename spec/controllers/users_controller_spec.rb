require 'rails_helper'
RSpec.describe UsersController, type: :controller do
  let!(:user) do
    FactoryBot.create(:user)
  end

  describe 'GET #index' do
    let(:user2) do
      FactoryBot.create(:user)
    end

    it 'populates an array of all Users' do
      get :index
      expect(assigns(:users)).to match_array [user, user2]
    end
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
      get :show, params: { id: user.id }
      expect(response).to render_template :show
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the user' do
      expect do
        delete :destroy, params: { id: user.id }
      end.to change(User, :count).by(-1)
    end
  end

  describe 'POST #create' do
    let(:valid_params) do
      FactoryBot.attributes_for(:user)
    end

    it 'creates a user with params and saves it' do
      expect do
        post :create, params: { user: valid_params }
      end.to change(User, :count).by(1)
    end
  end

  describe 'GET #update' do
    let(:user3) do
      FactoryBot.create(:user)
    end

    it 'updates a User with params and saves it' do
      expect do
        patch :update, params: { id: user3.id, user: { first_name: 'Name123' } }
      end.to change { user3.reload.first_name }.to 'Name123'
    end

    it 'renders the :edit template when succedes' do
      get :update, params: { id: user.id, user: { username: 'test' } }
      expect(response).to redirect_to user_path(user)
    end

    it 'renders the :edit template when fails' do
      get :update, params: { id: user.id, user: { username: nil } }
      expect(response).to redirect_to edit_user_path(user)
    end
  end
end
