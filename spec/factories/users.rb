FactoryGirl.define do
  factory :user do
    sequence(:username){ |n| "user_##{n}" }
    password 'user'
    role 'Default account'
  end
end
