class Link < ActiveRecord::Base
  include Inbox
  mount_uploader :image, LinkImageUploader

  after_commit :fetch_title, unless: :title?
  after_commit :fetch_image, unless: :image?

  has_one :content_entity, as: :contentable, dependent: :destroy
  has_many :comments, as: :commentable

  def to_s
    url
  end

  private

  def fetch_title
    TitleFetcher.perform_async(id)
  end

  def fetch_image
    WebshotWorker.perform_async(id)
  end
end
