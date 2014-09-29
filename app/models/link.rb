class Link < ActiveRecord::Base
  after_save :fetch_title, if: :url_changed?
  has_one :content_entity, as: :contentable, dependent: :destroy

  def to_s
    url
  end

  private

  def fetch_title
    TitleFetcher.perform_async(self.id)
  end
end
