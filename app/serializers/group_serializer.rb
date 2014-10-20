class GroupSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :owner_id,
             :user_ids,
             :users

  def users
    object.user_ids
  end
end
