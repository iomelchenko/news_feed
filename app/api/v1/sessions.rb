module V1
  class Sessions < Grape::API
    namespace :sessions do
      before { check_auth }

      post do
        SessionCreator.new(params).execute
      end

      delete do
        SessionDestroyer.new(current_user).execute
      end
    end
  end
end
