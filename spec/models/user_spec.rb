require 'rails_helper'
RSpec.describe UsersController, type: :model do
  let(:user1) do
    FactoryBot.build(:user, username: nil)
  end
  it 'is not valid without a first_name' do
    expect(user1.valid?).to be_falsey
  end

  let(:user2) do
    FactoryBot.build(:user, password: nil)
  end
  it 'is not valid without a password' do
    expect(user2.valid?).to be_falsey
  end

  let(:user3) do
    FactoryBot.build(:user, password_confirmation: nil)
  end
  it 'is not valid without a password_confirmation' do
    expect(user3.valid?).to be_falsey
  end

  let(:user4) do
    FactoryBot.build(:user, password: '12', password_confirmation: '13')
  end
  it 'is not valid when password and password_confirmation not identical' do
    expect(user4.valid?).to be_falsey
  end

  let!(:user5) do
    FactoryBot.create(:user, username: 'test')
  end
  let(:user6) do
    FactoryBot.build(:user, username: 'test')
  end
  it 'is not valid when naming 2 users with same username' do
    expect(user6.save).to be_falsey
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
