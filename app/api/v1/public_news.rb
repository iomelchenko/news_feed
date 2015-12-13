module V1
  class PublicNews < Grape::API
    namespace :public_news do
      get do
        @news = News.published
      end

      get ":id" do
        @news = NewsSearcher.new(params).execute
      end
    end
  end
end
