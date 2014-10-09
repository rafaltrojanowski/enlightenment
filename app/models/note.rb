class Note < ActiveRecord::Base
  has_one :content_entity, as: :contentable, dependent: :destroy
  has_many :comments, as: :commentable

  def to_s
    body
  end
end
