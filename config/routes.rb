require 'api_constraints'

Rails.application.routes.draw do
  namespace :api, defaults: { format: :json }  do
    scope module: :v1,
              constraints: ApiConstraints.new(version: 1, default: true) do
      # We are going to list our resources here
      root to: 'api_clients#index'
      resources :api_clients, only: [:create, :index]
    end
  end
end
