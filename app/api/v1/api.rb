module V1
  class Api < Grape::API
    version 'v1', using: :path
    format :json
    default_format :json

    rescue_from ActiveRecord::RecordNotFound do |e|
      message = e.message.gsub(/\s*\[.*\Z/, '')
      Rack::Response.new(
          { success: false,
             status: 404,
             message: "not_found",
             errors: message }.to_json, 404,
          { 'Content-Type' => 'application/json' })
    end

    rescue_from Grape::Exceptions::ValidationErrors do |e|
      Rack::Response.new(
          { success: false,
             status: 422,
             message: 'validation error',
             errors: e.message }.to_json, 422,
          { 'Content-Type' => 'application/json' })
    end

    helpers do
      def check_auth
        unless authenticated || getting_api_key
          error!("401 Unauthorized", 401)
        end
      end

      def authenticated
        params[:api_key] && (@user = User.find_by_api_key(params[:api_key])) && (@user.api_key_expires_at > Time.now)
      end

      def getting_api_key
        params[:username].present? && params[:password].present?
      end

      def current_user
        User.find_by_api_key(params[:api_key]) || @user
      end
    end

    # resources:
    mount V1::Sessions
    mount V1::PublicNews
  end
end
