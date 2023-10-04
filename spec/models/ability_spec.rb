require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Ability do
  subject(:ability) { Ability.new(user) }

  describe 'for admin users' do
    let(:user) { FactoryBot.create(:user, role: :admin) }

    it { should be_able_to(:manage, :all) }
  end

  describe 'for regular users' do
    let(:user) { FactoryBot.create(:user, role: :user) }

    it { is_expected.to be_able_to(:create, Journal) }
    it { is_expected.to be_able_to(:read, Journal) }
    it { is_expected.to be_able_to(:update, Journal) }
    it { is_expected.to be_able_to(:destroy, Journal) }

    it { is_expected.to be_able_to(:create, JournalEntry) }
    it { is_expected.to be_able_to(:read, JournalEntry) }
    it { is_expected.to be_able_to(:update, JournalEntry) }
    it { is_expected.to be_able_to(:destroy, JournalEntry) }

    it { is_expected.to be_able_to(:create, User) }
    it { is_expected.to be_able_to(:show, User) }
    it { is_expected.to be_able_to(:new, User) }
    it { is_expected.to be_able_to(:update, User, id: user.id) }

    it { is_expected.to be_able_to(:index, Task) }
    it { is_expected.to be_able_to(:show, Task) }
  end

  describe 'for guests' do
    let(:user) { nil }

    it { is_expected.to be_able_to(:create, User) }
    it { is_expected.to be_able_to(:new, User) }
  end
end
