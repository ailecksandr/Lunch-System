module ItemsHelper
  def types_for_select
    [
      ['First Meal', 'first_meal'],
      ['Main Meal', 'main_meal'],
      %w(Drink drink)
    ]
  end

  def humanize_type!(type)
    case type.to_s
    when 'drink' then 'Drink'
    when 'main_meal' then 'Main Meal'
    when 'first_meal' then 'First Meal'
    end
  end
end
