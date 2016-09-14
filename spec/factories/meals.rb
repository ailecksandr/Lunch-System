include WorkingDayseable

FactoryGirl.define do
  factory :meal do
    price Faker::Commerce.price(100)
  end

  factory :previous_meal, parent: :meal do
    created_at { working_days_ago(1) }
  end
end
