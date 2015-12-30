task :take_snapshot => :environment do
  # is there anything else to this? I don't think so -- just set this up in a cron job
  RemoteSiteSnapshot.create!(Rails.application.secrets.sitemap_base_url)
end
