class Api::V1::ContentEntitiesController < ApplicationController
  respond_to :json

  def index
    group_ids = current_user.group_ids
    scope = ContentEntity.where(group_id: group_ids)

    if params[:type].present?
      scope = current_user.content_entities.where(contentable_type: params[:type].humanize)
    end

    if params[:inbox].present?
      scope = current_user.content_entities.where(inbox: true)
    end

    # if params[:user_id].present?
      # scope = ContentEntity.where(user_id: params[:user_id])
    # end

    # if params[:group_id].present?
      # scope = scope.where(group_id: params[:group_id])
    # end

    respond_with scope
  end

  # def inbox
    # respond_with current_user.content_entities.inbox, root: false
  # end

  def create
    attrs = {
      content: params[:contentEntity][:body],
      user_id: params[:contentEntity][:user_id],
      group_id: params[:contentEntity][:group_id],
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
