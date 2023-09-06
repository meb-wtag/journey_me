require 'rails_helper'
RSpec.describe UsersController, type: :controller do 	
	let(:user_1) do
    FactoryBot.create(:user, id: 1)
  end

	# describe 'GET #index' do 
	# 	let!(:user_2) do
  #     FactoryBot.create(:user)
  #  	end

  #  	it 'populates an array of all Users' do
	# 		get :index, params: { id: 1 }
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
			get :show, params: { id: 1 }
			expect(assigns :user).to eq journal_1
    end
  end

  # describe 'DELETE #destroy' do 
	# 	it 'deletes the journal' do
  #     expect {
  #       delete :destroy, params: { id: 1 }
  #     }.to change(Journal, :count).by(-1)
  #   end

  #   it 'renders the :show template' do
  #     delete :destroy, params: { id: 1 }
  #     expect(response).to redirect_to journals_path
  #   end
  # end

  #  describe 'POST #create' do 
  #  	let(:valid_params) do
  #       FactoryBot.attributes_for(:journal)
  #     end

	# 	it 'creates a journal with params and saves it' do
	# 		expect do
  #       post :create, params: { journal: valid_params }
  #       end.to change(Journal, :count).by(1)
  #   end

  #   it 'ridirects to journals_path' do
  #     post :create, params: { journal: valid_params }
  #     expect(response).to redirect_to(journals_path)
  #   end
  # end
end
