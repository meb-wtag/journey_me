require 'rails_helper'
RSpec.describe Journal, type: :model do
  it 'is not valid without a title' do
    journal = Journal.new(description: 'Sample description')
    expect(journal.valid?).to be_falsey
  end

  it 'is not valid without a description' do
    journal = Journal.new(title: 'Sample title')
    expect(journal.valid?).to be_falsey
  end
end
