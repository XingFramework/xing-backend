require 'xing/snapshot/site_snapshot'
require 'xing/snapshot/fetcher'

module Xing
  module Snapshot
    class RemoteSiteSnapshot < SiteSnapshot
      def setup
        @fetcher = Xing::Snapshot::Fetcher.new
      end

      def fetch(url, path)
        @fetcher.perform(url, path)
      end
    end
  end
end
