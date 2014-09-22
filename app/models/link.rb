class Link < ActiveRecord::Base
  has_one :content_entity, as: :contentable, dependent: :destroy

  def to_s
    url
  end
end
