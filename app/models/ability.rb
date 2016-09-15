class Ability
  include CanCan::Ability, WorkingDayseable

  def initialize(user)
    can :index, Meal

    if user

      unless user.system?
        can :change_password, User if user.uid.blank?
        can [:edit, :update], User
      end

      case user.role
      when 'admin'
        can [:index, :clear_tokens], User
        !weekday?(Time.now)? can(:manage, Meal) : can(:menu_details, Meal)
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
