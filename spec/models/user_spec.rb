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

  let(:user7) do
    FactoryBot.build(:user)
  end
  it 'when creating a user it has the role of a user' do
    expect(user7.role).to eq 'user'
  end
end
