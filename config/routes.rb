Rails.application.routes.draw do
  namespace :api do
    mount AllApi => '/'
  end
end
