FactoryGirl.define do
  factory :comment do
    sequence(:comment){ |n| "Comment for news ##{n}" }
    news { News.first }
    user { User.first }
  end
end
