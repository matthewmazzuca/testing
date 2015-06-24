class  User
	class Api::V1::RegistrationsController < Devise::RegistrationsController


		skip_before_filter :verify_authenticity_token
			respond_to :json

			def register
		    build_resource(sign_up_params)
		    if resource.save
		      render :json => {:result => 'OK'}
		    else
		      render :json => {:result => 'ERROR'}
		  end
		end
			
		private

		def sign_up_params
			params.require(:user).permit(:email, :password, :password_confirmation)
		end

		def account_update_params
			params.require(:user).permit(:email, :password, :password_confirmation, :current_password)
		end

	end
end