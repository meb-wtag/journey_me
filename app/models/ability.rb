class Ability
  include CanCan::Ability

  def initialize(user)
    if user.present?
      if user.admin?
        can :manage, :all
      else
        can %i(create read update destroy), [Journal, JournalEntry]
        can %i(create show new), User
        can :update, User, id: user.id
        cannot :index, User
      end
    else
      can %i(create new), User
    end
  end
end
