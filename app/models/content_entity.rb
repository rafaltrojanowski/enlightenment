class ContentEntity < ActiveRecord::Base
  WEB_URL_REGEXP = /\A#{URI::regexp(['http', 'https'])}\z/

  attr_accessor :content
  default_scope { order(created_at: :desc) }

  belongs_to :contentable, polymorphic: true

  before_create :create_entity

  delegate :to_s, to: :contentable

  private

  def create_entity
    !!(content =~ WEB_URL_REGEXP) ? create_link : create_note
  end

  def create_link
    self.contentable = Link.create!(url: content)
  end

  def create_note
    self.contentable = Note.create!(body: content)
  end
end
