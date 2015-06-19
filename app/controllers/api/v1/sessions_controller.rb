class Api::V1::SessionsController < Devise::SessionsController
  skip_before_filter :authenticate_user_from_token!, :authenticate_user!
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
