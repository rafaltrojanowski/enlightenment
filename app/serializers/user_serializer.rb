class UserSerializer < ActiveModel::Serializer
  attributes :id,
             :email,
             :username,
             :name,
             :avatar,

  def avatar
    object.avatar_url
  end
end
