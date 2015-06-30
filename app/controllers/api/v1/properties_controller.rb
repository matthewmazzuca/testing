class Api::V1::PropertiesController < ApplicationController
  skip_before_filter :authenticate_user_from_token!, :only => [:show, :index]
  skip_before_filter :authenticate_user!, :only => [:show, :index]
  skip_before_filter :verify_authenticity_token

  respond_to :json

  def index
    properties = Property.all
    render json: properties
  end

  def show
    respond_with Property.find(params[:id])   
  end

  def create
    property = current_user.properties.build(property_params) 
    if property.save
      render json: property, status: 201, location: [:api, :v1, property] 
    else
      render json: { errors: property.errors }, status: 422
    end
    
  end

  def update
    property = current_user.properties.find(params[:id])
    if property.update(property_params)
      render json: property, status: 200, location: [:api, :v1, property] 
    else
      render json: { errors: property.errors }, status: 422
    end
    respond_with :api, :v1, property
  end

  def destroy
    property = current_user.properties.find(params[:id]) 
    property.destroy
    head 204
  end

  private

  def property_params
    params.require(:property).permit(:name, :price, :location, :image_url, :user_id, :address, :description, :lat, :lng, :created_at, :updated_at, fields: [:id, :name, :value]) 
  end

end


