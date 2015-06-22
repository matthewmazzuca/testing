class Api::V1::HighlightsController < ApplicationController
  before_action :authenticate_with_token!, only: [:create, :update, :destroy]
  respond_to :json

  def index
    highlights = highlight.search(params).page(params[:page]).per(params[:per_page])
    render json: highlights, meta: pagination(highlights, params[:per_page])
  end

  def show
    respond_with option.find(params[:id])   
  end

  def create
    highlight = current_user.properties.highlights.build(option_params) 
    if highlight.save
      render json: highlight, status: 201, location: [:api, highlight] 
    else
      render json: { errors: highlight.errors }, status: 422
    end
  end

  def update
    highlight = current_user.properties.highlights.find(params[:id])
    if highlight.update(highlight_params)
      render json: highlight, status: 200, location: [:api, highlight] 
    else
      render json: { errors: highlight.errors }, status: 422
    end
  end

  def destroy
    highlight = current_user.highlights.find(params[:id]) 
    highlight.destroy
    head 204
  end

  private

    def option_params
      params.require(:highlight).permit(:name, :location_id, :created_at, :updated_at, :uuid) 
    end

end