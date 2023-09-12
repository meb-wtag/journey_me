require 'rails_helper'
RSpec.describe JournalEntry, type: :model do
  describe 'associations' do
    it { should belong_to(:journal).class_name('Journal') }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }
  end

  let(:journal) { FactoryBot.create(:journal) }
  let(:entry) { FactoryBot.create(:journal_entry, journal:) }
  it 'is inversely associated with posts' do
    expect(journal.journal_entries.first.journal).to eq(journal)
  end
end
