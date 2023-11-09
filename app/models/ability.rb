class Ability
  include CanCan::Ability
  def initialize(user)
  user = current_user # guest user (not logged in)
    if user.admin? # Admin can do anything
      can :manage, :all
    else # Normal user can only read
      can :read, :all
    end
  end
end
