class Api::V1::UsersController < ApplicationController
  before_action :authenticate_with_token!, only: [:update, :destroy]
  respond_to :json

  # def index
  #   users = Users.search(params).page(params[:page]).per(params[:per_page])
  #   render json: users, meta: pagination(user_device, params[:per_page])
  # end


  def update
    user = current_user

    if user.update(user_params)
      render json: user, status: 200, location: [:api, user] 
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def destroy
    current_user.destroy
    head 204
  end

  private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation) 
    end
end
