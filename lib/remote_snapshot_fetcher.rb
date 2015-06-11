require 'snapshot_writer'
require 'addressable/uri'

class RemoteSnapshotFetcher
  include Sidekiq::Worker
  include SnapshotWriter

  def perform(url, path)
    admin_server = Rails.application.secrets.snapshot_server['url']
    user_password = "#{Rails.application.secrets.snapshot_server['user']}:#{Rails.application.secrets.snapshot_server['password']}"
    snapshot_url = Addressable::URI.join(url,path).to_s
    request = Typhoeus::Request.new(admin_server, userpwd: user_password, params: { url: snapshot_url })

    hydra = Typhoeus::Hydra.new
    hydra.queue(request)
    hydra.run

    response = request.response

    if response.success?
      html = response.body
      write(path, html)
    else
      logger.warn response.status_message
      logger.warn response.body
      raise "Query to #{admin_server} for #{path} failed!"
    end
  end

end
