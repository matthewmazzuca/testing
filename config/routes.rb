require 'api_constraints'

OpenhouseApi::Application.routes.draw do
  resources :options
  resources :highlights
  # nobody puts baby in a namespace
  devise_for :users,
    path: '/api/v1/users',
    controllers: { sessions: 'api/v1/sessions' }

  # Api definition
  namespace :api, defaults: { format: :json } do
    namespace :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      # We are going to list our resources here
      resources :users, :only => [:show, :create, :update, :destroy] do
      # resources :properties, :only => [:create, :update, :destroy]
      #   resources :beacons, :only => [:index, :show, :create]
      end

      resources :properties, :only => [:create, :update, :destroy]
        resources :beacons, :only => [:index, :show, :create]
      
      resources :products, :only => [:show, :index]
    end
  end
end
