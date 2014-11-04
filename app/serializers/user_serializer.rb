class UserSerializer < ActiveModel::Serializer
  attributes :id,
             :email,
             :username,
             :name,
             :avatar,
             :group

  def avatar
    object.avatar_url
  end

  def group
    object.groups
  end

  def group_ids
    object.groups_ids
  end
end
