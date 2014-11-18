class ContentEntitySerializer < ActiveModel::Serializer
  attributes :id,
             :type,
             :body,
             :updated_at,
             :title,
             :description,
             :avatar,
             :image,
             :group_id,
             :user_id,
             :group,
             :inbox,
             :can_edit,
             :can_destroy

  def group_id
    object.group_id
  end

  def group
    object.group_id
  end

  has_many :comments, as: :commentable, key: :comments # if console have errors delete key

  def body
    # url for link / body for note
    object.contentable.to_s rescue ''
  end

  def type
    object.contentable_type.downcase
  end

  def title
    object.contentable.title
  end

  def description
    if object.contentable.is_a? Link
      object.contentable.description
    else
      nil
    end
  end

  def avatar
    object.user.avatar_url
  end

  def image
    src = if object.contentable.is_a? Note
      'https://dl.dropboxusercontent.com/u/57582960/note.png'
    else
      object.contentable.image_url
    end
  end

  def inbox
    object.inbox?
  end

  def can_edit
    check_permission
  end

  def can_destroy
    check_permission
  end

  private

  def check_permission
    object.user_id == scope.current_user.try(:id)
  end
end
