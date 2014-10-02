class Api::V1::ContentEntitiesController < ApplicationController
  respond_to :json

  def index
    respond_with ContentEntity.all
  end

  def create
    attrs = {
      content: params[:contentEntity][:body],
      user_id: current_user.id
      # group_id: # TODO
    }

    respond_with :api, :v1, ContentEntity.create(attrs)
  end

  def update
    record = ContentEntity.find(params[:id]).contentable

    if object = record.update_attributes(title: params[:contentEntity][:title])
      render json: object
    else
      render json: object, status: 422
    end
  end

  def show
    respond_with ContentEntity.find(params[:id])
  end
end
