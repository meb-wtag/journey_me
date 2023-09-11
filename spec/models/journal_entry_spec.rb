require 'rails_helper'
RSpec.describe JournalEntry, type: :model do

  let(:journal) do
    FactoryBot.create(:journal)
  end

  let(:entry) do
    FactoryBot.build(:journal_entry, title: nil)
  end
  it 'is not valid without a title' do
    expect(entry.valid?).to be_falsey
  end

  let(:entry1) do
    FactoryBot.build(:journal_entry, content: nil)
  end
  it 'is not valid without content' do
    expect(entry1.valid?).to be_falsey
  end
end
