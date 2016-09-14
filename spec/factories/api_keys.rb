FactoryGirl.define do
  factory :api_key do end

  factory :custom_key, parent: :api_key do
    access_token '1234'
    expired_at { 1.minutes.from_now }
  end

  factory :inactive_key, parent: :api_key do
    expired_at { 1.minutes.ago }
  end

  factory :static_key, parent: :inactive_key do
    static true
  end
end
