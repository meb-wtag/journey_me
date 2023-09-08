require 'rails_helper'
RSpec.describe TasksController, type: :model do 
	it 'is not valid without a title' do
    user = Task.new(description: 'Desc')
    expect(user.valid?).to be_falsey
  end

  it 'is not valid without a description' do
    user = Task.new(title: 'Title')
    expect(user.valid?).to be_falsey
  end 
end