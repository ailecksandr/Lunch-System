module MenusHelper
  include Paramsable

  def menu_class(date)
    case
    when date.today? then 'active panel-primary'
    when Meal.menu_completed?(date) then 'panel-info'
    else 'panel-default'
    end
  end

  def humanize_type!(type)
    type.to_s.split('_').map(&:capitalize).join(' ')
  end
end
