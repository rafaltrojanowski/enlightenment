class UserSerializer < ActiveModel::Serializer
  attributes :id,
             :email,
             :name,
             :username,
             :nickname,
             :avatar,
             :dummy_msg

  def name
    object.username
  end

  def dummy_msg
    "JUST HERE FOR FUN #{object.email}"
  end

  def avatar
    object.avatar_url
  end
end
