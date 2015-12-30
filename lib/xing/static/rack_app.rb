require 'xing/static/backend_url_cookie'
require 'xing/static/goto_param'
require 'xing/static/logger'

module Xing
  module Static
    class RackApp
      # Should be override by client app. Ironically, override with exactly
      # this definition will usually work.
      def self.log_root
        File.expand_path("../../log", __FILE__)
      end

      def self.logpath_for_env(env)
        File.join( log_root, "#{env}_static.log")
      end

      def self.build(root_path, backend_port)
        backend_url = "http://localhost:#{backend_port}/"
        env = ENV['RAILS_ENV'] || 'development'
        logger = Logger.new(logpath_for_env(env))

        Rack::Builder.new do
          use BackendUrlCookie, backend_url
          use GotoParam
          use Rack::CommonLogger, logger
          use Rack::Static, {
            :urls => [""],
            :root => root_path,
            :index => "index.html",
            :header_rules => {
              :all => {"Cache-Control" => "no-cache, max-age=0" } #no caching development assets
            }
          }
          run proc{}
        end
      end
    end
  end
end
