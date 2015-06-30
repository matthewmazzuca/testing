class Api::V1::BeaconsController < ApplicationController
  skip_before_filter :authenticate_user_from_token!, :only => [:show, :index]
  skip_before_filter :authenticate_user!, :only => [:show, :index]
  skip_before_filter :verify_authenticity_token

  respond_to :json

  def index
    beacons = Beacon.all
    render json: beacons
  end

  def show
    respond_with Beacon.find(params[:id])   
  end

  def create
    # beacon = current_user.beacons.build(product_params) 
    beacon = Beacon.new(beacon_params)
    if beacon.save
      render json: beacon, status: 201, location: [:api, :v1, beacon] 
    else
      render json: { errors: beacon.errors }, status: 422
    end
  end

  def update
    beacon = current_user.properties.beacons.find(params[:id])
    if beacon.update(beacon_params)
      render json: beacon, status: 200, location: [:api, :v1, beacon] 
    else
      render json: { errors: beacon.errors }, status: 422
    end
  end

  def destroy
    beacon = current_user.beacons.find(params[:id]) 
    beacon.destroy
    head 204
  end

  # private

  #   def product_params
  #     params.require(:beacon).permit(:name, :location_id, :created_at, :updated_at, :uuid) 
  #   end

end