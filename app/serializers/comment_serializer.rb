class CommentSerializer < ActiveModel::Serializer
  attributes :id,
             :content,
             :user_id,
             :commentable_id,
             :commentable_type,
             :updated_at,
             :avatar,
             :commenter_name,
             :can_destroy

  def avatar
    object.user.avatar_url
  end

  def commenter_name
    object.user.name
  end

  def can_destroy
    # @TODO possibility to use cancan here?
    object.user_id == scope.current_user.try(:id)
  end
end
