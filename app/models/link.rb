class Link < ActiveRecord::Base
  mount_uploader :image, LinkImageUploader

  after_commit :fetch_title
  has_one :content_entity, as: :contentable, dependent: :destroy

  def to_s
    url
  end

  private

  def fetch_title
    TitleFetcher.perform_async(id)
    WebshotWorker.perform_async(id)
  end
end
