require 'rails_helper'
RSpec.describe User, type: :model do
  let(:user) do
    FactoryBot.build(:user)
  end
  let(:user2) do
    FactoryBot.build(:user, password: '12', password_confirmation: '13')
  end
  let!(:user5) do
    FactoryBot.create(:user, username: 'test')
  end
  let(:user6) do
    FactoryBot.create(:user, username: 'test')
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_uniqueness_of(:username) }
    it { is_expected.to validate_presence_of(:role) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_presence_of(:password_confirmation) }
    it 'is not valid when password and password_confirmation not identical' do
    expect(user2.valid?).to be_falsey
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:journals) }
    it { is_expected.to have_one_attached(:profile_picture) }
  end
end
