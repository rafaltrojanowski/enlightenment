class LinkSerializer < ActiveModel::Serializer
  attributes :id,
             :url,
             :updated_at,
             :title,
             :avatar,
             :image

  def avatar
    src = if object.content_entity.try(:user).try(:avatar?)
      object.content_entity.user.avatar_url
    else
      'https://dl.dropboxusercontent.com/u/57582960/doge.png'
    end
  end

  def image
    src = if object.image?
      object.image_url
    else
      'https://dl.dropboxusercontent.com/u/57582960/note.png'
    end
  end
end
