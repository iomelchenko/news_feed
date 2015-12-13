module V1
  class PublicNews < Grape::API
    namespace :public_news do
      get do
        @news = News.published
      end
    end
  end
end
