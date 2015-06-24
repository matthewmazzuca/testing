class Api::V1::SessionsController < Devise::SessionsController
  skip_before_filter :authenticate_user_from_token!, :authenticate_user!
  # prepend_before_filter :require_no_authentication, only: [:new, :create]
  # prepend_before_filter :allow_params_authentication!, only: :create
  # prepend_before_filter :verify_signed_out_user, only: :destroy
  # prepend_before_filter only: [:create, :destroy] { request.env["devise.skip_timeout"] = true }
  respond_to :json

  def create
    super do |user|
      if request.format.json?
        data = {
          token: user.authentication_token,
          email: user.email
        }
        render json: data, status: 201 and return
      end
    end
  end

  def destroy
    user = User.find_by(auth_token: params[:id])
    user.generate_authentication_token
    user.save
    head 204
  end
end

#   def sign_in_params
#     devise_parameter_sanitizer.sanitize(:sign_in)
#   end

#   def serialize_options(resource)
#     methods = resource_class.authentication_keys.dup
#     methods = methods.keys if methods.is_a?(Hash)
#     methods << :password if resource.respond_to?(:password)
#     { methods: methods, only: [:password] }
#   end

#   def auth_options
#     if request.format.json?
#       super.merge(store: false)
#     else
#       super
#     end
#   end

#   def translation_scope
#     'devise.sessions'
#   end

#   private

#   # Check if there is no signed in user before doing the sign out.
#   #
#   # If there is no signed in user, it will set the flash message and redirect
#   # to the after_sign_out path.
#   def verify_signed_out_user
#     if all_signed_out?
#       set_flash_message :notice, :already_signed_out if is_flashing_format?

#       respond_to_on_destroy
#     end
#   end

#   def all_signed_out?
#     users = Devise.mappings.keys.map { |s| warden.user(scope: s, run_callbacks: false) }

#     users.all?(&:blank?)
#   end

#   def respond_to_on_destroy
#     # We actually need to hardcode this as Rails default responder doesn't
#     # support returning empty response on GET request
#     respond_to do |format|
#       format.all { head :no_content }
#       format.any(*navigational_formats) { redirect_to after_sign_out_path_for(resource_name) }
#     end
#   end
# end