module V1
  class PublicNews < Grape::API
    namespace :news do
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
        if requested_user.can? :create, News
          @news = NewsCreator.new(params, current_user).execute
        else
          error!("403 Access denied", 403)
        end
      end

      put ":id" do
        check_auth
        if requested_user.can? :update, News
          @news = NewsStateChanger.new(params).execute
        else
          error!("403 Access denied", 403)
        end
      end
    end
  end
end
