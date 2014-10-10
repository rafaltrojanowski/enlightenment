class Note < ActiveRecord::Base
  TITLE_LENGTH = 20

  has_one :content_entity, as: :contentable, dependent: :destroy
  has_many :comments, as: :commentable

  def to_s
    body
  end

  # TODO remove db column
  def title
    body[0..TITLE_LENGTH].concat('...')
  end
end
