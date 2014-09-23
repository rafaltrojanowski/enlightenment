class ContentEntitySerializer < ActiveModel::Serializer
  attributes :id, :type, :_content, :updated_at, :title

  # NOTE content not works - reserved word ?
  def _content
    object.contentable.to_s # url for link / body for note
  end

  def type
    object.contentable_type.downcase
  end

  def title
    object.contentable_type.downcase == 'link' ? object.contentable.title : ''
  end
end
