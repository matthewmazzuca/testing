class Api::V1::UserDevicesController < ApplicationController
  before_action :authenticate_with_token!, only: [:create, :update, :destroy]
  respond_to :json

  def index
    user_devices = UserDevices.search(params).page(params[:page]).per(params[:per_page])
    render json: user_devices, meta: pagination(user_device, params[:per_page])
  end

  def show
    respond_with UserDevices.find(params[:id])   
  end

  def create
    user_device = current_user.user_devices.build(product_params) 
    if user_device.save
      render json: user_device, status: 201, location: [:api, user_device] 
    else
      render json: { errors: user_device.errors }, status: 422
    end
  end

  def update
    user_device = current_user.user_devices.find(params[:id])
    if user_device.update(property_params)
      render json: user_device, status: 200, location: [:api, user_device] 
    else
      render json: { errors: user_device.errors }, status: 422
    end
  end

  def destroy
    user_device = current_user.user_devices.find(params[:id]) 
    user_device.destroy
    head 204
  end

  private

    def product_params
      params.require(:user_device).permit(:name, :user_id, :created_at, :updated_at) 
    end

end


