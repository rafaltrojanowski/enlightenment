class ContentEntitySerializer < ActiveModel::Serializer
  attributes :id,
             :type,
             :body,
             :updated_at,
             :title,
             :avatar,
             :image

  def body
    # url for link / body for note
    object.contentable.to_s.gsub(/\n/, '<br/>')
  end

  def type
    object.contentable_type.downcase
  end

  def title
    object.contentable.title
  end

  def avatar
    src = if object.try(:user).try(:avatar?)
      object.user.avatar_url
    else
      'https://dl.dropboxusercontent.com/u/57582960/doge.png'
    end
  end

  def image
    src = if object.contentable.is_a? Note
      'https://dl.dropboxusercontent.com/u/57582960/note.png'
    else
      object.contentable.image_url
    end
  end
end
