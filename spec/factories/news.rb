FactoryGirl.define do
  factory :news do
    sequence(:title){ |n| "Title for news ##{n}" }
    sequence(:body){ |n| "Text for news ##{n}  ..." }
    user { User.first }
  end
end
