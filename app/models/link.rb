class Link < ActiveRecord::Base
  before_save :fetch_title
  has_one :content_entity, as: :contentable, dependent: :destroy

  def to_s
    url
  end

  private

  def fetch_title
    return if url.blank?

    begin
      doc = Pismo::Document.new(url)
      self.title = doc.title
    rescue # RuntimeError: redirection forbidden
      return
    end
  end
end
