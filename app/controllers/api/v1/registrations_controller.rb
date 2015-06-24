class  User
	class Api::V1::RegistrationsController < Devise::RegistrationsController
		prepend_before_filter :require_no_authentication, only: [:new, :create, :cancel]
 	 	prepend_before_filter :authenticate_scope!, only: [:edit, :update, :destroy]

		skip_before_filter :verify_authenticity_token
			respond_to :json

			
		private

		def sign_up_params
			params.require(:user).permit(:email, :password, :password_confirmation)
		end

		def account_update_params
			params.require(:user).permit(:email, :password, :password_confirmation, :current_password)
		end

	end
end