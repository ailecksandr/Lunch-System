module MenusHelper
  include WorkingDayseable

  def menu_class(date)
    case
    when date.today? then 'active panel-primary'
    when Meal.menu_completed?(date) then 'panel-info'
    else 'panel-default'
    end
  end

  def menu_item_index(type)
    (MenuItem.last.id rescue 0) + Item.item_types[type] + 1
  end
end
