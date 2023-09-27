class Ability
  include CanCan::Ability

  def initialize(user)
    if user.present?
      can %i(create read update destroy), Journal
      can %i(create read update destroy), JournalEntry
      can %i(create show new ), User
      can :all, UserSession

      if user.admin?
        can :manage, :all
      end
    end
  end
end
