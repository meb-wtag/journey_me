class Ability
  include CanCan::Ability

  def initialize(user)
    if user.present?
      can %i(create read update destroy), Journal
      can %i(create read update destroy), JournalEntry
      can %i(create show new), User
      can :update, User, id: user.id
      cannot :index, User
      if user.admin?
        can :manage, :all
      end
    else
      can %i(create show new), User
    end
  end
end
