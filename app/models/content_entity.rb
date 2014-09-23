class ContentEntity < ActiveRecord::Base
  attr_accessor :content
  default_scope { includes(:contentable).order(created_at: :desc) }

  belongs_to :contentable, polymorphic: true

  before_create :create_entity

  delegate :to_s, to: :contentable

  private

  def create_entity
    begin
      uri = URI.parse(content)

      if uri && uri.host && %(http https).include?(uri.scheme)
        create_link
      else
        create_note
      end
    rescue => error
      logger.error error
      create_note
    end
  end

  def create_link
    self.contentable = Link.create(url: content)
  end

  def create_note
    self.contentable = Note.create(body: content)
  end
end
