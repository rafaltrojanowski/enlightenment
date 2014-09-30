class ContentEntitySerializer < ActiveModel::Serializer
  attributes :id,
             :type,
             :body,
             :updated_at,
             :title,
             :avatar

  def body
    # url for link / body for note
    object.contentable.to_s
  end

  def type
    object.contentable_type.downcase
  end

  def title
    object.contentable_type.downcase == 'link' ? object.contentable.title : ''
  end

  def avatar
    src = if object.try(:user).try(:avatar?)
      object.user.avatar_url
    else
      'https://dl.dropboxusercontent.com/u/57582960/doge.png'
    end
  end
end
