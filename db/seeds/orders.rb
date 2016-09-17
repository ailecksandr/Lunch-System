load("#{Rails.root}/db/seeds/meals.rb")

Order.delete_all

(1..5).each do |i|
  Random.rand(1..5).times do
    current_day_meals = Meal.up_to_date(working_days_ago(i))
    order = Order.new(
        user: User.worker.offset(Random.rand(User.worker.size)).first,
        created_at: working_days_ago(i),
        status: (!Random.rand(3).zero?) ? 'open' : 'closed',
        first_meal_id: current_day_meals.first_meal.ids.sample,
        main_meal_id: current_day_meals.main_meal.ids.sample,
        drink_id: current_day_meals.drink.ids.sample
    )
    order.save
  end
end
