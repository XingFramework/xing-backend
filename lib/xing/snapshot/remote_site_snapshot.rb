require 'xing/snapshot/site_snapshot'

module Xing
  module Snapshot
    class RemoteSiteSnapshot < SiteSnapshot
      def setup
        @fetcher = Xing::Services::SnapshotFetcher.new
      end

      def fetch(url, path)
        @fetcher.perform(url, path)
      end
    end
  end
end
