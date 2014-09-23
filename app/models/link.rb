class Link < ActiveRecord::Base
  after_commit :fetch_title
  has_one :content_entity, as: :contentable, dependent: :destroy

  def to_s
    url
  end

  private

  def fetch_title
    TitleFetcher.perform_async(self.id)
  end
end
