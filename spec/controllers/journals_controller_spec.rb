require 'rails_helper'
RSpec.describe JournalsController, type: :controller do
  let!(:user) do
    FactoryBot.create(:user, role: :admin)
  end

  before do
    sign_in_as!(user)
  end

  let(:journal) { FactoryBot.create(:journal, user: user) }
  let(:valid_params) { FactoryBot.attributes_for(:journal) }

  describe 'GET #new' do
    let!(:journal3) { FactoryBot.create(:journal, user:) }

    it 'assigns a new Journal to @journal' do
      get :new, params: { user_id: user.id }
      expect(assigns(:journal)).to be_a_new(Journal)
    end

    it 'renders the :new template' do
      get :new, params: { user_id: user.id, id: journal.id }
      expect(response).to render_template :new
    end
  end

  describe 'GET #show' do
    it 'displays the requested Journal to @journal' do
      get :show, params: { user_id: user.id, id: journal.id }
      expect(assigns(:journal)).to eq journal
    end

    it 'renders the :show template' do
      get :show, params: { user_id: user.id, id: journal.id }
      expect(response).to render_template :show
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the journal' do
      delete :destroy, params: { user_id: user.id, id: journal.id }
      expect { journal.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'renders the :show template' do
      delete :destroy, params: { user_id: user.id, id: journal.id }
      expect(response).to redirect_to user_path
    end
  end

  describe 'POST #create' do
    it 'creates a journal with params and saves it' do
      expect do
        post :create, params: { user_id: user.id, journal: valid_params }
      end.to change(Journal, :count).by(1)
    end
  end

  describe 'POST #upload_file' do
    file_path = 'spec/test_assets/2.jpg'
    test_file = Rack::Test::UploadedFile.new(file_path, 'image/jpg')
    it 'uploads a file and attaches it' do
      expect do
        post :upload_file, params: { user_id: user.id, id: journal.id, files: [test_file] }
      end.to change(journal.files, :count).by(1)
      expect(journal.reload.files).to be_attached
    end
  end

  describe 'DELETE #delete_file' do
    let(:journal) { FactoryBot.create(:journal, user: user) }
    let(:file_path) { 'spec/test_assets/2.jpg' }
    let(:test_file) { Rack::Test::UploadedFile.new(file_path, 'image/jpg') }

    it 'deletes a file attached to the journal' do
      journal.files.attach(io: test_file, filename: '2.jpg', content_type: 'image/jpg')
      file_to_delete = journal.files.last

      expect do
        delete :delete_file, params: { user_id: user.id, id: journal.id, file_id: file_to_delete.id }
      end.to change(ActiveStorage::Attachment, :count).by(-1)
      expect(journal.reload.files).to_not be_attached
    end
  end

  describe "GET #calendar" do
    it "renders the :calendar template" do
      get :calendar, params: {user_id: user.id, journal_id: journal.id }
      expect(response).to render_template(:calendar)
    end
  end
end
