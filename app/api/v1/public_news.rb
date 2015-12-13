module V1
  class PublicNews < Grape::API
    namespace :public_news do
      get do
        @news = News.published
      end

      get ":id" do
        @news = NewsSearcher.new(params).execute
      end

      params do
        requires :title, type: String, allow_blank: false
        requires :body, type: String, allow_blank: false
      end

      post do
        check_auth
        @news = NewsCreator.new(params, current_user).execute
      end

      put ":id" do
        check_auth
        @news = NewsStateChanger.new(params).execute
      end
    end
  end
end
