class Api::V1::ContentEntitiesController < ApplicationController
  respond_to :json

  def index
    scope = ContentEntity.all

    if params[:user_id].present?
      scope = scope.where(user_id: params[:user_id])
    end

    if params[:type].present?
      scope = scope.where(contentable_type: params[:type].humanize)
    end

    if params[:inbox].present?
      scope = scope.where(inbox: true)
    end

    respond_with scope
  end

  def inbox
    respond_with current_user.content_entities.inbox, root: false
  end

  def create
    attrs = {
      content: params[:contentEntity][:body],
      user_id: params[:contentEntity][:user_id],
    }

    respond_with :api, :v1, ContentEntity.create(attrs)
  end

  def update
    record = ContentEntity.find(params[:id]).contentable
    do_update = record.is_a?(Link) ? update_link(record) : update_note(record)

    if object = do_update
      render json: object
    else
      render json: object, status: 422
    end
  end

  def show
    respond_with ContentEntity.find(params[:id])
  end

  def destroy
    respond_with ContentEntity.find(params[:id]).destroy
  end

  private

  def update_link(record)
    record.content_entity.update_column(:group_id, params[:contentEntity][:group_id])
    record.update_attributes(title: params[:contentEntity][:title],
                             description: params[:contentEntity][:description])
  end

  def update_note(record)
    record.content_entity.update_column(:group_id, params[:contentEntity][:group_id])
    record.update_attributes(body: params[:contentEntity][:body],
                             title: params[:contentEntity][:title])
  end
end
