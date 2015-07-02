require 'api_constraints'

Openhouseapi::Application.routes.draw do
  resources :contacts
  get 'home/index'

  # nobody puts baby in a namespace
  root :to => 'home#index'

  devise_for :users, path: 'api/v1/users', controllers: { sessions: 'api/v1/sessions', registrations: "api/v1/registrations" }

  # Api definition
  namespace :api, defaults: { format: :json } do
    # namespace :v1, constraints: ApiConstraints.new(version: 1, default: true) do
    namespace :v1 do
      # We are going to list our resources here
      # resource :users
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
