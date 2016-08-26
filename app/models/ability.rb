class Ability
  include CanCan::Ability

  def initialize(user)
    if user.role?(:admin)
      can :index, User
    end
  end
end
