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

    if params[:search].present?
      keyword = params[:search]
      tag_part = scope.tagged_with(keyword).pluck(:id)

      note_part = ContentEntity.joins("INNER JOIN notes 
                                       ON content_entities.contentable_id = notes.id 
                                       AND content_entities.contentable_type = 'Note'").where("(lower(title) like ? 
                                                                                               OR lower(body) like ?) 
                                                                                               AND group_id in (?)", "%#{keyword.downcase}%", "%#{keyword.downcase}%", current_user.group_ids).pluck(:id).uniq
      link_part = ContentEntity.joins("INNER JOIN links 
                                       ON content_entities.contentable_id = links.id 
                                       AND content_entities.contentable_type = 'Link'").where("(lower(title) like ? 
                                                                                               OR url like ?) 
                                                                                               AND group_id in (?)", "%#{keyword.downcase}%", "%#{keyword.downcase}%", current_user.group_ids).pluck(:id).uniq

      merge_ids = (tag_part + note_part + link_part).uniq
      scope = ContentEntity.find(merge_ids)
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
    @content_entity.update_with_contentable(params) if params[:contentEntity].present?
    @content_entity.tag_list = params[:contentEntity][:tags_cache]

    if @content_entity.save
      render json: @content_entity
    else
      render json: @content_entity, status: 422
    end
  end

  def show
    respond_with @content_entity
  end

  def destroy
    respond_with @content_entity.destroy
  end
end
