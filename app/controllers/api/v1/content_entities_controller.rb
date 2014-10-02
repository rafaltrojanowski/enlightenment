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
    type = params[:contentEntity][:type]

    record = ContentEntity.find(params[:id]).contentable

    obj = record.update!(title: params[:contentEntity][:title])

    respond_with :api, :v1, obj, status: :ok
  end

  def show
    respond_with ContentEntity.find(params[:id])
  end
end
