require 'rails_helper'
RSpec.describe UsersController, type: :model do 
	it 'is not valid without a first_name' do
    user = User.new(last_name: 'last Name')
    expect(user.valid?).to be_falsey
  end

  it 'is not valid without a last_name' do
    user = User.new(first_name: 'Name')
    expect(user.valid?).to be_falsey
  end 
end
