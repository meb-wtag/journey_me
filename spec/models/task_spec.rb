require 'rails_helper'
RSpec.describe Task, type: :model do
  let!(:user) { FactoryBot.create(:user) }
  let(:task) { FactoryBot.create(:task, creator_id: user.id) }

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it 'sets default importance and status' do
      expect(task.priority).to eq('medium')
      expect(task.status).to eq('todo')
    end

    describe 'filetype validations' do
      it 'valid filetype' do
        task.files.attach(io: File.open('app/assets/images/2.jpg'), filename: '2.jpg', content_type: 'image/jpg')
        expect(task).to be_valid
      end

      it 'invalid filetype' do
        task.files.attach(io: File.open('app/assets/images/00001-Welcome.mp4'), filename: '00001-Welcome.mp4', content_type: 'video/mp4')
        expect(task).to_not be_valid
      end
    end

    describe 'filesize validations' do
      it 'valid size' do
        task.files.attach(io: File.open('app/assets/images/2.jpg'), filename: '2.jpg', content_type: 'image/jpg')
        expect(task).to be_valid
      end

      it 'invalid size' do
        task.files.attach(io: File.open('app/assets/images/CF022715.png'), filename: 'CF022715.png', content_type: 'image/png')
        expect(task).to_not be_valid
      end
    end
  end

  describe 'associations' do
    it { should have_many(:users).join_table(:assignments) }
  end
end
