require 'rails_helper'
RSpec.describe User, type: :model do
  let(:user) do
    FactoryBot.build(:user)
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_presence_of(:role) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_presence_of(:password_confirmation) }
  end

  let(:user2) do
    FactoryBot.build(:user, password: '12', password_confirmation: '13')
  end
  it 'is not valid when password and password_confirmation not identical' do
    expect(user2.valid?).to be_falsey
  end

  let!(:user5) do
    FactoryBot.create(:user, username: 'test')
  end
  let(:user6) do
    FactoryBot.create(:user, username: 'test')
  end
  it { is_expected.to validate_uniqueness_of(:username) }

  describe 'associations' do
    it { is_expected.to have_many(:journals) }
  end
end
