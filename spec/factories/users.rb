FactoryGirl.define do
  factory :user do
    sequence(:nickname) {|n| "Typical User #{n}" }
    sequence(:email) {|n| "user_#{n}@lunch.com" }
    password { Faker::Internet.password }
    after(:build) {|user| user.skip_confirmation! }
  end

  factory :admin, parent: :user do
    role 'admin'
  end

  factory :api_client, parent: :user do
    role 'system'
  end

  factory :user_from_social, parent: :user do
    provider :google
    uid { Faker::Number.number(21) }
  end
end
