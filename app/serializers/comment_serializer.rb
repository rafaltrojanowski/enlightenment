class CommentSerializer < ActiveModel::Serializer
  attributes :id,
             :content,
             :user_id,
             # :user,
             :commentable_id,
             :commentable_type,
             :updated_at,
             :avatar,
             :commenter_name

  # def user
  #   object.user_id
  # end
  def avatar
    user = User.find_by_id(object.user_id)
    if user.try(:avatar?)
      user.avatar_url
    else
      'https://dl.dropboxusercontent.com/u/57582960/doge.png'
    end
  end

  def commenter_name
    user = User.find_by_id(object.user_id)
    if user.try(:username?)
      user.username
    else
      user.email
    end
  end
end
