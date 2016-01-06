module Xing
  module Snapshot
    module DomainHelpers
      def domain(url = nil)
        if url
          url
        elsif defined? Rails.application.secrets.sitemap_base_url
          Rails.application.secrets.sitemap_base_url
        else
          raise "No Domain is set for the sitemap.  Please set it in secrets.yml."
        end
      end

      def page_frontend_url(path)
        if PAGES_FRONTEND_URL.present?
          PAGES_FRONTEND_URL + "/" + path
        else
          path
        end
      end
    end

  end
end
