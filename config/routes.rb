require 'api_constraints'

Rails.application.routes.draw do
  namespace :api, defaults: { format: :json }  do
    scope module: :v1,
              constraints: ApiConstraints.new(version: 1, default: true) do
      resources :api_clients, only: [:create]
      put 'update_expired_token', to: "api_clients#update_expired_token"
    end
  end
end
