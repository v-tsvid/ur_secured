require 'api_constraints'

Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    scope module: :v1, 
      constraints: ApiConstraints.new(version: 1, default: true) do
      
      resources :api_clients, only: [:create, :update, :show]
      resources :analyses, only: [:create, :show]

      post 'get_token',                to: "api_clients#create"
      put  'update_expired_token/:id', to: "api_clients#update"
      get  'client_stats/:id',         to: "api_clients#show"
      post 'analyze_content',          to: "analyses#create"
      get  'check_analysis/:id',       to: "analyses#show"
    end
  end
end
