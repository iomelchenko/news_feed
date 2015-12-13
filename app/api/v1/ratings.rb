module V1
  class Ratings < Grape::API
    namespace :ratings do
      params do
        requires :target_type, type: String, allow_blank: false
        requires :target_id, type: Integer, allow_blank: false
        requires :rating, type: Integer, allow_blank: false
      end

      put do
        current_user_id = current_user.id if current_user.present?
        @rating = RatingsEditor.new(params, current_user_id).execute
      end
    end
  end
end
