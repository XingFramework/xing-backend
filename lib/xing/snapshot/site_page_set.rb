require 'xing/snapshot/domain_helpers'

module Xing
  module Snapshot
    class SitePageSet
      include DomainHelpers

      def initialize(url)
        @url = domain(url)
      end

      def pages_to_visit
        @pages_to_visit ||= Page.published.where.not(type: "Page::Homepage")
      end

      def visit_pages(&block)
        STATIC_PATHS_FOR_SITEMAP.each do |path|
          yield(@url,path,Time.now)
        end

        pages_to_visit.each do |page|
          path = page_frontend_url(page.url_slug)
          yield(@url, path, page.updated_at)
        end
      end
    end

  end
end
