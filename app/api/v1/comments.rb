module V1
  class Comments < Grape::API
    namespace 'news/:news_id' do
      namespace :comments do

        params do
          requires :news_id, type: Integer, allow_blank: false
        end

        get do
          @comments = Comment.where(news_id: @params[:news_id])
        end

        params do
          requires :comment, type: String, allow_blank: false
          requires :news_id, type: Integer, allow_blank: false
        end

        post do
          current_user_id = current_user.id if current_user.present?
          @comment = CommentsCreator.new(params, current_user_id).execute
        end
      end
    end
  end
end
