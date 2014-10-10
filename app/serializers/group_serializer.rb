class GroupSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :owner_id,
             :users

  def users
    object.user_ids
  end
end
