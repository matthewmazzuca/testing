require 'api_constraints'

OpenhouseApi::Application.routes.draw do
  # nobody puts baby in a namespace

  devise_for :users, :skip => [:sessions, :passwords, :registrations]

  # Api definition
  namespace :api, defaults: { format: :json } do
    # namespace :v1, constraints: ApiConstraints.new(version: 1, default: true) do
    namespace :v1 do
      # We are going to list our resources here
      # resource :users
      # resources :properties, :only => [:create, :update, :destroy]
      #   resources :beacons, :only => [:index, :show, :create]
      devise_for :users, controllers: { sessions: 'api/v1/sessions', :registration => "api/v1/registrations" }
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
