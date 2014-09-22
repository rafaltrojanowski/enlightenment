class ContentEntitySerializer < ActiveModel::Serializer
  attributes :id, :type, :_content, :updated_at

  # NOTE content not works - reserved word ?
  def _content
    object.contentable.to_s # url for link / body for note
  end

  def type
    object.contentable_type.downcase
  end
end
