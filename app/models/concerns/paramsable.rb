module Paramsable
  def meals_params_from_file
    meals_params = JSON.parse(File.read('public/meals.json'))['meals']
                       .map{|params| params.map{|key, value| [key.to_sym, value] }.to_h }
    Meal.meal_types.keys.map{|type| [type, meals_params.select{|params| params[:meal_type] == type }] }.to_h
  end
end