FactoryGirl.define do
  factory :rating do
    rating rand(1...5)
    target_id { News.first.id }
    target_type 'News'
    user { User.first }
  end
end
