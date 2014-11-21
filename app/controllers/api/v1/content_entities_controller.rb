class Api::V1::ContentEntitiesController < ApplicationController
  load_and_authorize_resource
  respond_to :json

  def index
    scope = @content_entities

    if params[:type].present?
      scope = scope.where(user_id: current_user.id,
                          contentable_type: params[:type].humanize)
    end

    if params[:inbox].present?
      scope = current_user.content_entities.where(inbox: true)
    end

    respond_with scope
  end

  def create
    attrs = {
      content: params[:contentEntity][:body],
      group_id: params[:contentEntity][:group_id],
      user_id: current_user.try(:id)
    }

    respond_with :api, :v1, ContentEntity.create(attrs)
  end

  def update
    record = ContentEntity.find(params[:id])
    record.tag_list = params[:contentEntity][:tags_cache]

    record.contentable.is_a?(Link) ? update_link(record.contentable) : update_note(record.contentable)

    if record.save
      render json: record
    else
      render json: record, status: 422
    end
  end

  def show
    respond_with ContentEntity.find(params[:id])
  end

  def destroy
    respond_with ContentEntity.find(params[:id]).destroy
  end

  private

  # @TODO move to model
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
