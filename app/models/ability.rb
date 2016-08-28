class Ability
  include CanCan::Ability

  def initialize(user)
    can :index, Meal

    if user

      if user.worker?
        can :change_password, User if user.uid.blank?
        can [:edit, :update], User
      end

      case user.role
      when 'admin'
        can [:index, :clear_tokens], User
        can :manage, Item
        can :manage, Meal
        can :manage, Order
      when 'system'
        can :token, User
      else
        can :menu_details, Meal
        can [:create, :order_details], Order
      end

    end
  end
end
