module Xing
  module Snapshot
    module Writer
      def write(path, html)
        snapshot_file = "#{ Rails.root }/public/frontend_snapshots/#{path.present? ? path : 'index'}.html"
        dirname = File.dirname(snapshot_file)
        FileUtils.mkdir_p(dirname)

        File.open(snapshot_file, "w+:ASCII-8BIT:UTF-8") do |f|
          f.write(html)
        end
      end
    end
  end
end
