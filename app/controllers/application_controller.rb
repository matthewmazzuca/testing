class ApplicationController < ActionController::Base
  # before_filter :authenticate_user_from_token!
  # before_action :authenticate_user!
  # # before_action :authenticate_admin!
  # # before_action :configure_permitted_parameters, if: :devise_controller?

  # # Enter the normal Devise authentication path,
  # # using the token authenticated user if available
  # before_filter :authenticate_user!


  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :null_session
  private

  def authenticate_user_from_token!
    authenticate_with_http_token do |token, options|
      user_email = options[:email].presence
      user = user_email && User.find_by_email(user_email)

      if user && Devise.secure_compare(user.authentication_token, token)
        sign_in user, store: false
      end
    end
  end

  protected

    def pagination(paginated_array, per_page)
      { pagination: { per_page: per_page.to_i,
                      total_pages: paginated_array.total_pages,
                      total_objects: paginated_array.total_count } }
    end

end
