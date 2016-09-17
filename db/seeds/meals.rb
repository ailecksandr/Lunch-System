include WorkingDayseable, Paramsable

Meal.delete_all

meals_params = meals_params_from_file

(1..5).each do |i|
  Meal.meal_types.keys.each do |type|
    existing_names = []

    Random.rand(1..5).times do
      params = meals_params[type].select{|params| existing_names.exclude? params[:name] }.sample
      params.merge!(
          created_at: working_days_ago(i),
          price: Random.rand((type != 'drink')? (10.0...75.0) : (1.0...10.0))
      )
      Meal.create(params)
      existing_names << params[:name]
    end
  end
end