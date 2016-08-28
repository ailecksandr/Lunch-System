FactoryGirl.define do
  factory :item do
    sequence(:name) { |n| "product #{n}" }
  end

  factory :first_item, parent: :item do
    item_type :first_meal
  end

  factory :main_item, parent: :item do
    item_type :main_meal
  end

  factory :drink_item, parent: :item do
    item_type :drink
  end
end
