require 'rails_helper'
RSpec.describe JournalEntry, type: :model do

  journal_test = Journal.new

  it 'is not valid without a title' do
    entry = JournalEntry.new(journal: journal_test, content: 'Sample description')
    expect(entry.valid?).to be_falsey
  end

  it 'is not valid without content' do
    entry = JournalEntry.new(journal: journal_test, title: 'journal_test')
    expect(entry.valid?).to be_falsey
  end
end
