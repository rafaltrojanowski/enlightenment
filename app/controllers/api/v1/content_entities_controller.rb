class Api::V1::ContentEntitiesController < ApplicationController
  respond_to :json

  def index
    respond_with ContentEntity.all
  end

  def create
    # respond_with ContentEntity.create(content: params[:contentEntity][:_content])
    ContentEntity.create(content: params[:contentEntity][:_content])

    render json: 'ok', status: 200
  end

  def show
    respond_with ContentEntity.find(params[:id])
  end
end
