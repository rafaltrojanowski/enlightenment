class NoteSerializer < ActiveModel::Serializer
  attributes  :id,
              :title,
              :body,
              :updated_at,
              :avatar,
              :comments
  has_many :comments, as: :commentable

  def avatar
    src = if object.content_entity.try(:user).try(:avatar?)
      object.content_entity.user.avatar_url
    else
      'https://dl.dropboxusercontent.com/u/57582960/doge.png'
    end
  end

  def comments
    object.comments
  end

end
