class Api::V1::HighlightsController < ApplicationController
  skip_before_filter :authenticate_user_from_token!, :only => [:show, :index]
  skip_before_filter :authenticate_user!, :only => [:show, :index]
  skip_before_filter :verify_authenticity_token

  respond_to :json
  
  def index
    highlights = Highlight.all
    render json: highlights
  end

  def show
    respond_with Highlight.find(params[:id])   
  end

  def create
    highlight = current_user.properties.highlights.build(option_params) 
    if highlight.save
      render json: highlight, status: 201, location: [:api, :v1, highlight] 
    else
      render json: { errors: highlight.errors }, status: 422
    end
  end

  def update
    highlight = current_user.properties.highlights.find(params[:id])
    if highlight.update(highlight_params)
      render json: highlight, status: 200, location: [:api, :v1, highlight] 
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