class CommentSerializer < ActiveModel::Serializer
  attributes :id,
             :content,
             :user_id,
             :user,
             :commentable_id,
             :commentable_type,
             :updated_at

  def user
    object.user_id
  end
end
