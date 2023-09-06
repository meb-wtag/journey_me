require 'rails_helper'
RSpec.describe JournalsController, type: :controller do 	
	let!(:journal_1) do
     	FactoryBot.create(:journal,id: 1)
   	end

	describe 'GET #index' do 
		let!(:journal_2) do
     	FactoryBot.create(:journal, title: 'Test2', description: 'abc' )
   	end

   	it 'populates an array of all Journals' do
			get :index
    	expect(assigns(:journals)).to match_array [journal_1, journal_2]
    end

   	it 'renders the :index template' do
			get :index
    	expect(response).to render_template :index
    end
	end

	describe 'GET #new' do 
		it 'assigns a new Journal to @journal' do
			get :new
    	expect(assigns :journal).to be_a_new(Journal)
    end

   	it 'renders the :new template' do
			get :new
    	expect(response).to render_template :new
    end
	end

	describe 'GET #show' do 
		it 'displays the requested Journal to @journal' do
			get :show, params: { id: 1 }
			expect(assigns :journal).to eq journal_1
    end

    it 'renders the :show template' do
      get :show, params: { id: 1 }
      expect(response).to render_template :show
    end
  end

  describe 'DELETE #destroy' do 
		it 'deletes the journal' do
      expect {
        delete :destroy, params: { id: 1 }
      }.to change(Journal, :count).by(-1)
    end

    it 'renders the :show template' do
      delete :destroy, params: { id: 1 }
      expect(response).to redirect_to journals_path
    end
  end

   describe 'POST #create' do 
   	let(:valid_params) do
        FactoryBot.attributes_for(:journal)
      end

		it 'creates a journal with params and saves it' do
			expect do
        post :create, params: { journal: valid_params }
        end.to change(Journal, :count).by(1)
    end

    it 'ridirects to journals_path' do
      post :create, params: { journal: valid_params }
      expect(response).to redirect_to(journals_path)
    end
  end
end
