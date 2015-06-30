# class  User
	class Api::V1::RegistrationsController < Devise::RegistrationsController

		skip_before_filter :verify_authenticity_token
		respond_to :json

		# def create
	 #    user = User.new(user_params) 
	 #    if user.save
	 #      render json: user, status: 201
	 #    else
	 #      render json: { errors: user.errors }, status: 422
	 #    end
	 #  end

			
		private

		def user_params
			params.require(:user).permit(:email, :password, :password_confirmation)
		end

		def account_update_params
			params.require(:user).permit(:email, :password, :password_confirmation, :current_password)
		end

	end
# end