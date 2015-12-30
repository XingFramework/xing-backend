require "xing/snapshot/site_page_set"

module Xing
  module Snapshot
    class SiteSnapshot
      class << self
        def create!(url)
          self.new(url).create!
        end
      end

      def initialize(url)
        @url = url
      end
      attr_accessor :url

      def create!
        @sitemap_page_set = SitePageSet.new(url)
        setup
        generate_snapshot
        teardown
      end

      def setup
      end

      def generate_snapshot
        @sitemap_page_set.visit_pages do |url, path, updated_at|
          fetch(url, path)
        end
      end

      def fetch(url, path)
      end

      def teardown
      end
    end

  end
end
