class TitleFetcher
  include Sidekiq::Worker
  def perform(id)
    sleep 1

    link = Link.find(id)
    return if link.url.blank?

    begin
      doc = Pismo::Document.new(link.url)
      link.update_column(:title, doc.title)
    rescue # RuntimeError: redirection forbidden
      return
    end
  end
end
