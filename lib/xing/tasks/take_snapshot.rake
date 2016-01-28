require 'xing/snapshot/remote_site_snapshot'

task :take_snapshot => :environment do
  # is there anything else to this? I don't think so -- just set this up in a cron job
  Xing::Snapshot::RemoteSiteSnapshot.create!(Rails.application.secrets.sitemap_base_url)
end
