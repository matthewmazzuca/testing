require 'api_constraints'

OpenhouseApi::Application.routes.draw do
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

      resources :properties, :only => [:index, :create, :update, :destroy] do
        resources :beacons, :only => [:index, :show, :create, :update, :destroy]
        resources :highlights, :only => [:index, :show, :create, :update, :destroy] do
          resources :options, :only => [:index, :show, :create, :destroy]
        end
      end
      # resources :products, :only => [:show, :index]
    end
  end
end
