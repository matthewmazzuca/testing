class Api::V1::PropertiesController < ApplicationController
  # before_action :authenticate_with_token!, only: [:create, :update, :destroy]
  skip_before_filter :verify_authenticity_token, :only => :create
  respond_to :json


  def index
    properties = Property.all
    render json: properties
  end

  def show
    respond_with Property.find(params[:id])   
  end

  def create
    property = current_user.property.build(product_params)  
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
    params.require(:property).permit(:name, :price, :location, :image_url, :user_id, :address, :description, :lat, :lng, :created_at, :updated_at, fields: [:id, :name, :value]) 
  end

end


