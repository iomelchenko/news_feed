News feed backend application with API

You can show application routes using command:
  rake grape:routes

Examples of implemented REST requests:

News model:
  get news
    curl -i -X GET "http://localhost:3000/api/v1/public_news"
