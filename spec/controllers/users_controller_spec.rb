require 'rails_helper'
RSpec.describe UsersController, type: :controller do 	

  let!(:user) do
    FactoryBot.create(:user, id: 2 ,first_name: 'John', last_name: 'Doe')
  end
	# describe 'GET #index' do 
	# 	let!(:user_2) do
  #     FactoryBot.create(:user)
  #  	end

  #  	it 'populates an array of all Users' do
	# 		get :index
  #   	expect(assigns(:users)).to match_array [user_1, user_2]
  #   end
	# end

	describe 'GET #new' do 
		it 'assigns a new User to @user' do
			get :new
    	expect(assigns :user).to be_a_new(User)
    end

   	it 'renders the :new template' do
			get :new
    	expect(response).to render_template :new
    end
	end

	describe 'GET #show' do 
		it 'displays the requested User to @user' do
			get :show, params: { id: 2 }
			expect(assigns :user).to eq user
    end

    it 'renders the :show template' do
      get :show, params: { id: 2 }
      expect(response).to render_template :show
    end
  end

  describe 'DELETE #destroy' do 
		it 'deletes the user' do
      expect {
        delete :destroy, params: { id: 2 }
      }.to change(User, :count).by(-1)
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
end
