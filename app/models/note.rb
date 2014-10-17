class Note < ActiveRecord::Base
  include Inbox

  TITLE_LENGTH = 20

  has_one :content_entity, as: :contentable, dependent: :destroy
  has_many :comments, as: :commentable

  def to_s
    body
  end
end
