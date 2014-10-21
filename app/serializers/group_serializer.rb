class GroupSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :owner_id,
             :icon,
             :users,
             :user_ids

  def users
    object.user_ids
  end
end
