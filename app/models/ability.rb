class Ability
  include CanCan::Ability

  def initialize(user)
    if user.present?
      can :manage, :all
      # can %i(create read update destroy), Journal
      # can %i(create read update destroy), JournalEntry
      # can %i(create show new ), User
      # can :all, UserSession
    end
  end
end
