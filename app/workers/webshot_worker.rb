class WebshotWorker
  include Sidekiq::Worker

  def perform(id)
    sleep 1
    path_img = "tmp/webshots/link-webshot-#{id}.png"

    link = Link.find_by_id(id)

    return unless link

    ws = Webshot::Screenshot.instance
    ws.capture link.url,
               path_img,
               width: 400,
               height: 350,
               quality: 85

    link.image = File.open(path_img)
    link.save!

    File.delete(path_img)
  end
end
