class Ability
  include CanCan::Ability

  def initialize(user)
    user = current_user

    if user.admin?
      can :manage, :all
    elsif user.user?
      can :read, :all
      can :create, :all
      can :destroy, :all
    else
      can :read, :all
    end
end
