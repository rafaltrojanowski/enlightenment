class GroupSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :owner_id,
             :icon,
             :users,
             :user_ids,
             :can_update

  has_many :content_entities

  def users
    object.user_ids
  end

  def can_update
    object.owner_id == scope.current_user.try(:id)
  end
end
