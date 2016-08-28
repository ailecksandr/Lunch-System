json.(menu_item, :id)

json.meal do |json|
  json.price menu_item.meal.price

  json.item do |json|
    json.name menu_item.meal.item.name
  end
end