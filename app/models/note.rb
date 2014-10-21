class Note < ActiveRecord::Base
  include Inbox
  before_create :set_title

  TITLE_LENGTH = 20

  has_one :content_entity, as: :contentable, dependent: :destroy
  has_many :comments, as: :commentable

  def to_s
    body
  end

  def set_title
    ignore_html = body.gsub( %r{</?[^>]+?>}, '' )
    self.title = ignore_html[0..TITLE_LENGTH].concat('...')
  end
end
