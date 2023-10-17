require 'rails_helper'
RSpec.describe Journal, type: :model do
  describe 'associations' do
    it { should belong_to(:user).class_name('User') }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
  end

  let!(:user) do
    FactoryBot.create(:user, role: :admin)
  end
  let(:journal) { FactoryBot.create(:journal, user: user) }
  let(:file_path) { 'spec/test_assets/2.jpg' }
  let(:valid_file) { Rack::Test::UploadedFile.new(file_path, 'image/jpg') }
  let(:file_path2) { 'spec/test_assets/figma_kit.fig' }
  let(:invalid_file) { Rack::Test::UploadedFile.new(file_path2) }

  it 'is valid with valid files' do
    journal.files.attach(valid_file)
    expect(journal).to be_valid
  end

  it 'is invalid with invalid files' do
    journal = Journal.new
    journal.files.attach(invalid_file)
    expect(journal).not_to be_valid
  end
end
