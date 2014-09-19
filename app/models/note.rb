class Note < ActiveRecord::Base
  has_one :content_entity, as: :contentable, dependent: :destroy

  def to_s
    body
  end
end
