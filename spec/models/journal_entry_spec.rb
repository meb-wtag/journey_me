require 'rails_helper'
RSpec.describe JournalEntry, type: :model do
  let!(:user) { FactoryBot.create(:user) }
  let!(:journal) { FactoryBot.create(:journal, user: user) }
  describe 'associations' do
    it { should belong_to(:journal).class_name('Journal') }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }
  end
end
