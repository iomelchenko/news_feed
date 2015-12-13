News feed backend application with API

You can show application routes using command:
  rake grape:routes


Examples of implemented REST requests:

sign_up:
  curl -i -X POST -d "username=user&password=user&role=Admin" "http://localhost:3000/api/v1/sign_up"

auth:
  log in (get token)
    curl -i -X POST -d "username=user_1&password=user_1" "http://localhost:3000/api/v1/sessions"

  log out (update auth token)
    curl -i -X DELETE -d "api_key=473ffe2ec622492abe1c52706f315320" "http://localhost:3000/api/v1/sessions"

News model:
  get news
    curl -i -X GET -d "api_key=d4dcf589cc164ff5988c7030bfc11c7b" "http://localhost:3000/api/v1/news"

  get news by ":id"
    curl -i -X GET -d "api_key=d4dcf589cc164ff5988c7030bfc11c7b" "http://localhost:3000/api/v1/news/1"

  post news
    curl -i -X POST -d "api_key=61c55dab30f24c7da1d1536cfb398dca&title=Great news&body=Great morning news" "http://localhost:3000/api/v1/news"

  approve news
    curl -i -X PUT -d "api_key=61c55dab30f24c7da1d1536cfb398dca&title" "http://localhost:3000/api/v1/news/2"

Comment model:
  create comment
    curl -i -X POST -d "api_key=61c55dab30f24c7da1d1536cfb398dca&title&comment=My great comment" "http://localhost:3000/api/v1/news/12/comments"

  get all comments for news
    curl -i -X GET -d "api_key=61c55dab30f24c7da1d1536cfb398dca&title" "http://localhost:3000/api/v1/news/12/comments"

Rating model:
  update rating for news
    curl -i -X PUT -d "api_key=61c55dab30f24c7da1d1536cfb398dca&title&target_type=News&target_id=11&rating=5" "http://localhost:3000/api/v1/ratings"

  update rating for comment
    curl -i -X PUT -d "api_key=61c55dab30f24c7da1d1536cfb398dca&title&target_type=Comment&target_id=8&rating=3" "http://localhost:3000/api/v1/ratings"
