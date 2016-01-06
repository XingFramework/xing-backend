require 'builder'
require 'xing/snapshot/site_page_set'
require 'xing/snapshot/domain_helpers'

module Xing
  module Snapshot
    class Sitemap
      class << self
        include DomainHelpers

        def create!(url = nil)
          @bad_pages = []

          @sitemap_page_set = SitePageSet.new(url)

          generate_sitemap
          update_search_engines if Rails.env.production?
        end

        private
        def generate_sitemap
          xml_str = ""

          xml = Builder::XmlMarkup.new(:target => xml_str, :indent => 2)

          xml.instruct!
          xml.urlset(:xmlns=>'http://www.sitemaps.org/schemas/sitemap/0.9') {
            @sitemap_page_set.visit_pages do |url, path, update_time|
              xml.url {
                xml.loc(url+path)
                xml.lastmod(update_time.utc.strftime('%Y-%m-%dT%H:%M:%S+00:00'))
              }
            end
          }

          save_file(xml_str)
        end

        def save_file(xml)
          File.open("#{ Rails.root }/public/sitemap.xml", "w+") do |f|
            f.write(xml)
          end
        end

        def update_search_engine(host, path, sitemap_uri)
          Rails.logger.info{"Notifying #{host}"}
          begin
            res = Net::HTTP.get_response(host, path + sitemap_uri)
          rescue Object => ex
            Rails.logger.info "Error while notifying #{host}: #{ex.inspect}"
          end
          Rails.logger.info res.class
        end

        # Notify popular search engines of the updated sitemap.xml
        def update_search_engines
          sitemap_uri = domain + 'sitemap.xml'
          escaped_sitemap_uri = CGI.escape(sitemap_uri)

          update_search_engine('www.google.com', '/webmasters/tools/ping?sitemap=', escaped_sitemap_uri)
          update_search_engine('search.yahooapis.com', '/SiteExplorerService/V1/updateNotification?appid=SitemapWriter&url=', escaped_sitemap_uri)
          update_search_engine('www.bing.com', '/webmaster/ping.aspx?siteMap=', escaped_sitemap_uri)
        end
      end
    end

  end
end
