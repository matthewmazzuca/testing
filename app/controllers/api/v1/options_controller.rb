class Api::V1::OptionsController < ApplicationController
  before_action :authenticate_with_token!, only: [:create, :update, :destroy]
  respond_to :json

  def index
    Options = Option.search(params).page(params[:page]).per(params[:per_page])
    render json: Options, meta: pagination(Options, params[:per_page])
  end

  def show
    # respond_with Product.find(params[:id])   
  end

  def create
    option = Option.new(option_params) 
    if option.save
      render json: option, status: 201, location: [:api, option] 
    else
      render json: { errors: option.errors }, status: 422
    end
  end

  def update
    option = current_user.properties.highlight.options.find(params[:id])
    if option.update(Option_params)
      render json: Option, status: 200, location: [:api, Option] 
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