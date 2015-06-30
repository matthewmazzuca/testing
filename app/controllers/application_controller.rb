class ApplicationController < ActionController::Base
  before_filter :authenticate_user_from_token!
  # # before_action :authenticate_admin!
  # # before_action :configure_permitted_parameters, if: :devise_controller?

  # # Enter the normal Devise authentication path,
  # # using the token authenticated user if available
  # before_filter :authenticate_user!, :except => [:index]
  before_filter :authenticate_user!

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  private

  def authenticate_user_from_token!
    authenticate_with_http_token do |token, options|
      user_email = options[:email].presence
      user = user_email && User.find_by_email(user_email)
      puts "authenticating"

      if user && Devise.secure_compare(user.authentication_token, token)
        sign_in user, store: false
      end
    end
  end

end
