module V1
  class SignUp < Grape::API
    namespace :sign_up do
      params do
        requires :username, type: String, allow_blank: false
        requires :password, type: String, allow_blank: false
      end

      post do
        UserCreator.new(params).execute
      end
    end
  end
end
