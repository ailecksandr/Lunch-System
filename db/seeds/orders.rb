include WorkingDayseable

Order.delete_all

(1..5).each do |i|
  Random.rand(1..5).times do
    order = Order.new(
        user: User.worker.offset(Random.rand(User.worker.size)).first,
        created_at: working_days_ago(i),
        status: (!Random.rand(3).zero?) ? 'open' : 'closed'
    )
    Item.item_types.keys.each do |type|
      collection = Meal.up_to_date(working_days_ago(i)).send(type)
      order.menu_items.new(meal: collection.offset(Random.rand(collection.size)).first)
    end
    order.save
  end
end
