require 'rails_helper'
RSpec.describe Journal, type: :model do
  let!(:journal) do
    FactoryBot.build(:journal, title: nil)
  end
  it 'is not valid without a title' do
  expect(journal.valid?).to be_falsey
  end

  let(:journal1) do
    FactoryBot.build(:journal, description: nil)
  end
  it 'is not valid without a description' do
  expect(journal1.valid?).to be_falsey
  end
end
