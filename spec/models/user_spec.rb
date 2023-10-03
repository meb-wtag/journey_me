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

  let(:user7) { FactoryBot.create(:user) }

  describe '#confirmation_token' do
    it 'generates a confirmation token if it is blank' do
      user7.confirm_token = nil
      user7.confirmation_token
      expect(user7.confirm_token).not_to be_nil
    end

    it 'does not generate a new token if one already exists' do
      existing_token = 'existing_token'
      user7.confirm_token = existing_token
      user7.confirmation_token
      expect(user7.confirm_token).to eq(existing_token)
    end
  end

  describe '#email_activate' do
    it 'marks the user as email_confirmed' do
      user7.email_confirmed = false
      user7.email_activate
      expect(user7.email_confirmed).to be(true)
    end

    it 'clears the confirmation token' do
      user7.confirm_token = 'some_token'
      user7.email_activate
      expect(user7.confirm_token).to be_nil
    end
  end
end
