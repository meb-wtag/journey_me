require 'rails_helper'
RSpec.describe JournalsController, type: :controller do 	
  let(:journal) { FactoryBot.create(:journal) }
	describe 'GET #index' do 
		let(:journal2) { FactoryBot.create(:journal) }

   	it 'populates an array of all Journals' do
			get :index
    	expect(assigns(:journals)).to match_array [journal, journal2]
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
			get :show, params: { id: journal.id }
			expect(assigns :journal).to eq journal
    end

    it 'renders the :show template' do
      get :show, params: { id: journal.id }
      expect(response).to render_template :show
    end
  end

  describe 'DELETE #destroy' do 
		it 'deletes the journal' do
        delete :destroy, params: { id: journal.id }
        expect { journal.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'renders the :show template' do
      delete :destroy, params: { id: journal.id }
      expect(response).to redirect_to journals_path
    end
  end

  describe 'POST #create' do 
    let(:valid_params) { FactoryBot.attributes_for(:journal) }

		it 'creates a journal with params and saves it' do
			expect do
        post :create, params: { journal: valid_params }
        end.to change(Journal, :count).by(1)
    end

    it 'redirects to journals_path' do
      post :create, params: { journal: valid_params }
      expect(response).to redirect_to(journals_path)
    end
  end
end
