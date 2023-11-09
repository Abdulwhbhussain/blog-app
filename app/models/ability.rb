class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?
    can :read, :all
    can :manage, Post, author_id: user.id
    can :manage, Comment, user_id: user.id
    
    can :manage, :all if user.admin?
  end
end
