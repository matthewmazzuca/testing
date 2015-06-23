class Api::V1::PropertiesController < ApplicationController
  # before_action :authenticate_with_token!, only: [:create, :update, :destroy]
  respond_to :json

  def index
    properties = Property.search(params).page(params[:page]).per(params[:per_page])
    render json: properties, meta: pagination(properties, params[:per_page])
  end

  def show
    respond_with Property.find(params[:id])   
  end

  def create
    property = current_user.properties.build(product_params) 
    if property.save
      render json: property, status: 201, location: [:api, property] 
    else
      render json: { errors: property.errors }, status: 422
    end
  end

  def update
    property = current_user.properties.find(params[:id])
    if property.update(property_params)
      render json: property, status: 200, location: [:api, property] 
    else
      render json: { errors: property.errors }, status: 422
    end
  end

  def destroy
    property = current_user.properties.find(params[:id]) 
    property.destroy
    head 204
  end

  private

    def product_params
      params.require(:property).permit(:name, :address, :description, :lat, :lng, :created_at, :updated_at) 
    end

end


