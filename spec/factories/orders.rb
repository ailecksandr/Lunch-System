FactoryGirl.define do
  factory :order do
    user
  end

  factory :completed_order, parent: :order do
    after(:build) do |order, evaluator|
      Item::TYPES.each do |type|
        item = FactoryGirl.create("#{type.split('_')[0]}_item")
        meal = FactoryGirl.create(:meal, item: item)
        FactoryGirl.create(:menu_item, order: order, meal: meal)
      end
    end
  end

  factory :closed_order, parent: :completed_order do
    status :closed
  end

  factory :previous_order, parent: :completed_order do
    created_at Time.now - 1.day
  end
end
