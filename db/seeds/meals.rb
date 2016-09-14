include WorkingDayseable

Meal.delete_all

(1..5).each do |i|
  Item.item_types.keys.each do |type|
    Random.rand(1..5).times do
      existing_item_names = Meal.up_to_date(working_days_ago(i)).joins(:item).where(items: { item_type: Item.item_types[type] }).pluck(:name).uniq
      collection = Item.send(type).where.not(name: existing_item_names)
      Meal.create(
          price: Random.rand((type != 'drink')? (10.0...75.0) : (1.0...10.0)),
          created_at: working_days_ago(i),
          item: collection.offset(Random.rand(collection.size)).first
      )
    end
  end
end
