FactoryGirl.define do
  factory :api_key do end

  factory :custom_key, parent: :api_key do
    access_token '1234'
    expired_at Time.now + 1.minutes
  end

  factory :inactive_key, parent: :api_key do
    expired_at Time.now - 1.minutes
  end

  factory :static_key, parent: :inactive_key do
    static true
  end
end
