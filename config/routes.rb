require 'api_constraints'

OpenhouseApi::Application.routes.draw do
  resources :fields
  # nobody puts baby in a namespace
  devise_for :users,
    path: '/api/v1/users',
    controllers: { sessions: 'api/v1/sessions' }

  # Api definition
  namespace :api, defaults: { format: :json } do
    # namespace :v1, constraints: ApiConstraints.new(version: 1, default: true) do
    namespace :v1 do
      # We are going to list our resources here
      resources :users, :only => [:show, :create, :update, :destroy]
      # resources :properties, :only => [:create, :update, :destroy]
      #   resources :beacons, :only => [:index, :show, :create]

      resources :properties do
        resources :beacons
        resources :highlights do
          resources :options
        end
      end
      # resources :products, :only => [:show, :index]
    end
  end
end
