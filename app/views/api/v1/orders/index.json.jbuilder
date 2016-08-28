json.prettify = true

json.array! @orders do |order|
  json.id order.id
  json.status order.status

  json.user do |json|
    json.nickname order.user.nickname
  end

  json.menu_items order.menu_items, partial: 'api/v1/orders/menu_item', as: :menu_item

  json.(order, :created_at, :updated_at)
end