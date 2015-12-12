# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = [{username: 'user_1', password: 'user_1', role: 'Default account'},
         {username: 'user_2', password: 'user_2', role: 'Default account'},
         {username: 'manager', password: 'manager', role: 'Manager'},
         {username: 'admin', password: 'admin', role: 'Admin'},
        ]

users.each do |user|
  User.create!(user)
end

news = [{title: 'News # 1', body: 'News # 1 from user #1 ...', user_id: 1},
        {title: 'News # 2', body: 'News # 2 from user #1 ...', user_id: 1},
        {title: 'News # 3', body: 'News # 3 from user #1 ...', user_id: 1},
        {title: 'News # 4', body: 'News # 4 from user #2 ...', user_id: 2},
        {title: 'News # 5', body: 'News # 5 from user #2 ...', user_id: 2}
       ]

news.each do |news|
  News.create!(news)
end

comments = [{comment: 'Comment # 1 from user # 1 for news # 1', user_id: 1, news_id: 1},
            {comment: 'Comment # 2 from user # 1 for news # 1', user_id: 1, news_id: 1},
            {comment: 'Comment # 3 from user # 1 for news # 2', user_id: 1, news_id: 2},
            {comment: 'Comment # 4 from user # 1 for news # 3', user_id: 1, news_id: 3},
            {comment: 'Comment # 5 from user # 2 for news # 4', user_id: 2, news_id: 4},
            {comment: 'Comment # 6 from user # 2 for news # 4', user_id: 2, news_id: 4},
            {comment: 'Comment # 7 from user # 2 for news # 5', user_id: 2, news_id: 5}
           ]

comments.each do |comment|
  Comment.create!(comment)
end

ratings = [{rating: 5, user_id: 1, target_type: 'Comment', target_id: 1},
           {rating: 1, user_id: 1, target_type: 'Comment', target_id: 2},
           {rating: 2, user_id: 1, target_type: 'Comment', target_id: 3},
           {rating: 4, user_id: 1, target_type: 'News', target_id: 1},
           {rating: 1, user_id: 1, target_type: 'News', target_id: 2},
           {rating: 2, user_id: 1, target_type: 'News', target_id: 3},
           {rating: 3, target_type: 'News', target_id: 5},
           {rating: 4, target_type: 'Comment', target_id: 7}
          ]

ratings.each do |rating|
  Rating.create!(rating)
end
