require 'api_constraints'

OpenhouseApi::Application.routes.draw do
  # nobody puts baby in a namespace
  devise_scope :user do
    post "api/v1/register" => "api/v1/registration#register"
  end

  devise_for :users, 
    path: '/api/v1/users',
    controllers: { sessions: 'api/v1/sessions', :registration => "registrations" } do
      get "api/v1/users/sign_up" => "users/registrations#new", :as => :user_signup
      get "api/v1/users/sign_in" => "api/v1/sessions", :as => :user_signin
  end

  # Api definition
  namespace :api, defaults: { format: :json } do
    # namespace :v1, constraints: ApiConstraints.new(version: 1, default: true) do
    namespace :v1 do
      # We are going to list our resources here
      resource :users
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
