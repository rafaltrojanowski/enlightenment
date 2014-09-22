class Api::V1::ContentEntitiesController < ApplicationController
  respond_to :json

  def index
    respond_with ContentEntity.all
  end

  def create
    respond_with :api, :v1, ContentEntity.create(content: params[:contentEntity][:_content])
  end

  def show
    respond_with ContentEntity.find(params[:id])
  end
end
