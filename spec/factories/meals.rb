include WorkingDayseable

FactoryGirl.define do
  factory :meal do
    name Faker::Commerce.product_name
    meal_type :first_meal
    price Faker::Commerce.price(100)
  end

  factory :main_meal, parent: :meal do
    meal_type :main_meal
  end

  factory :drink, parent: :meal do
    meal_type :drink
  end

  factory :previous_meal, parent: :meal do
    created_at { working_days_ago(1) }
  end
end
