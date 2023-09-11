require 'rails_helper'
RSpec.describe UsersController, type: :model do 
  let(:user) do
    FactoryBot.build(:user, first_name = nil)
  end
	it 'is not valid without a first_name' do
    expect(user.valid?).to be_falsey
  end

  let(:user2) do
    FactoryBot.build(:user, last_name = nil)
  end
  it 'is not valid without a last_name' do
    expect(user2.valid?).to be_falsey
  end 
end
