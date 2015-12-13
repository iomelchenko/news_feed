module V1
  class Api < Grape::API
    version 'v1', using: :path
    format :json
    default_format :json

    # resources:
    mount V1::PublicNews
  end
end
