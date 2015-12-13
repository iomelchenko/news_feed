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

    # resources:
    mount V1::PublicNews
  end
end
