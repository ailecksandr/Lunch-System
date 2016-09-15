json.prettify = true

json.array! @orders do |order|
  json.id order.id
  json.status order.status

  json.user do |json|
    json.nickname order.user.nickname
  end

  Meal.meal_types.keys.each do |type|
    json.partial! 'api/v1/orders/meal', locals: { meal: order.send(type), type: type }
  end

  json.total order.total

  json.(order, :created_at, :updated_at)
end