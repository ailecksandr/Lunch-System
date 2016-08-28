class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      if user.role?(:admin)
        can :index, User
        can :manage, Item
        can :manage, Meal
        can :manage, Order
      end
    end
  end
end
