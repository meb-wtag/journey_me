require 'rails_helper'
require "cancan/matchers"

RSpec.describe Ability do
  subject(:ability) { Ability.new(user) }

  describe 'for admin users' do
    let(:user) { FactoryBot.create(:user, role: 'admin') }

    it { should be_able_to(:manage, :all) }
  end

  describe 'for regular users' do
    let(:user) { FactoryBot.create(:user, role: 'user') }

    it { should be_able_to(:create, Journal) }
    it { should be_able_to(:read, Journal) }
    it { should be_able_to(:update, Journal) }
    it { should be_able_to(:destroy, Journal) }

    it { should be_able_to(:create, JournalEntry) }
    it { should be_able_to(:read, JournalEntry) }
    it { should be_able_to(:update, JournalEntry) }
    it { should be_able_to(:destroy, JournalEntry) }

    it { should be_able_to(:create, User) }
    it { should be_able_to(:show, User) }
    it { should be_able_to(:new, User) }
    it { should be_able_to(:update, User, id: user.id) }
    it { should_not be_able_to(:index, User) }
  end

  describe 'for guests' do
    let(:user) { nil }

    it { should be_able_to(:create, User) }
    it { should be_able_to(:new, User) }
    it { should_not be_able_to(:create, Journal) }
    it { should_not be_able_to(:create, JournalEntry) }
    it { should_not be_able_to(:show, User) }
    it { should_not be_able_to(:update, User) }
    it { should_not be_able_to(:index, User) }
  end
end
