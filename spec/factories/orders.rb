include WorkingDayseable

FactoryGirl.define do
  factory :order do
    user
    first_meal { FactoryGirl.create(:meal) }
    main_meal { FactoryGirl.create(:main_meal) }
    drink { FactoryGirl.create(:drink) }
  end

  factory :closed_order, parent: :order do
    status :closed
  end

  factory :previous_order, parent: :order do
    created_at { working_days_ago(1) }
  end
end
