FactoryGirl.define do
  factory :meal do
    price Faker::Commerce.price(100)
  end

  factory :previous_meal, parent: :meal do
    created_at Time.now - 1.day
  end
end
