class GroupSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :owner_id,
             :icon,
             :users,
             :user_ids,
             :content_entities

  def users
    object.user_ids
  end

  def content_entities
    object.content_entity_ids
  end
end
