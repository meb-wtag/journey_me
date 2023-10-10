require 'rails_helper'

RSpec.describe Assignment, type: :model do
  let(:user) { create(:user) }
  let(:task) { create(:task) }

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:task) }
  end
end
