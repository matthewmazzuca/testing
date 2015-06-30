class Api::V1::OptionsController < ApplicationController
  skip_before_filter :authenticate_user_from_token!, :only => [:show, :index]
  skip_before_filter :authenticate_user!, :only => [:show, :index]
  skip_before_filter :verify_authenticity_token

  respond_to :json

  def index
    options = Option.all
    render json: options
  end

  def show
    respond_with Option.find(params[:id])   
  end

  def create
    option = Option.new(option_params) 
    if option.save
      render json: option, status: 201, location: [:api, :v1, option] 
    else
      render json: { errors: option.errors }, status: 422
    end
  end

  def update
    option = current_user.properties.highlight.options.find(params[:id])
    if option.update(Option_params)
      render json: Option, status: 200, location: [:api, :v1, option] 
    else
      render json: { errors: option.errors }, status: 422
    end
  end

  def destroy
    option = current_user.properties.highlights.options.find(params[:id]) 
    option.destroy
    head 204
  end

  # private

  #   def product_params
  #     params.require(:Option).permit(:name, :location_id, :created_at, :updated_at, :uuid) 
  #   end

end