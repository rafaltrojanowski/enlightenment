class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :username, :dummy_msg

  def name
    object.username
  end

  def dummy_msg
    "JUST HERE FOR FUN #{object.email}"
  end
end
