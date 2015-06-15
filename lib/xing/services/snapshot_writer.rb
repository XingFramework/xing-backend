module Xing::Services
  module SnapshotWriter
    def write(path, html)
      if Rails.env.test?
        snapshot_file = "#{ Rails.root }/spec/fixtures/sitemap_scratch/#{path.present? ? path : 'index'}.html"
      else
        snapshot_file = "#{ Rails.root }/public/frontend_snapshots/#{path.present? ? path : 'index'}.html"
      end
      dirname = File.dirname(snapshot_file)
      unless File.directory?(dirname)
        FileUtils.mkdir_p(dirname)
      end

      File.open(snapshot_file, "w+:ASCII-8BIT:UTF-8") do |f|
        f.write(html)
      end
    end
  end
end
