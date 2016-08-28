module MenusHelper
  def items_for_select(type)
    Item.send("#{type}s")
  end

  def menu_class(index, date)
    if index.zero?
      'active panel-primary'
    elsif Meal.menu_completed?(date)
      'panel-info'
    else
      'panel-default'
    end
  end
end
