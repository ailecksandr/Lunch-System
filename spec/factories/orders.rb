include WorkingDayseable

FactoryGirl.define do
  factory :order do
    user

    before(:create) do |order|
      Item.item_types.keys.each do |type|
        item = FactoryGirl.create("#{type.split('_')[0]}_item")
        meal = FactoryGirl.create(:meal, item: item)
        order.menu_items.build(meal: meal)
      end
    end
  end

  factory :wrong_order, parent: :order do
    before(:create) do |order|
      order.menu_items.destroy_all
    end
  end

  factory :closed_order, parent: :order do
    status :closed
  end

  factory :previous_order, parent: :order do
    created_at { working_days_ago(1) }
  end
end
