class Api::V1::ContentEntitiesController < ApplicationController
  respond_to :json

  def index
    group_ids = User.first.group_ids
    scope = ContentEntity.where(group_id: group_ids, inbox: false)
    

    if params[:type].present?
      scope = scope.where(user_id: current_user.id,
                          contentable_type: params[:type].humanize)
    end

    total = scope.count

    if params[:inbox].present?
      scope = current_user.content_entities.where(inbox: true)
    end

    if params[:pagi].present?
      scope = scope.paginate(page: params[:pagi])
    end

    num = 27
    # fail 'tak' if total.is_a? Integer
    respond_with scope, meta: { total: total }
  end

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

  def page_resources(resources)
    {
      total: 50,
      test: 'wiksa'
    }
  end

end
