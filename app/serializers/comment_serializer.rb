class CommentSerializer < ActiveModel::Serializer
  attributes :id,
             :content,
             :user_id,
             :commentable_id,
             :commentable_type,
             :updated_at

  # belongs_to :commentable, polymorphic: true

  # def attributes
  #   data = super
  #   data[object.commentable_type.to_sym] = object.commentable_id
  #   data
  # end

end
