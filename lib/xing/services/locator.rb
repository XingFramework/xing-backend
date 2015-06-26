module Xing::Services
  module Locator

    def route_to(path)
      path = "http://#{BACKEND_SUBDOMAIN}.example.com#{normalize_path(path)}";
      router.recognize_path(path)
    end

    def normalize_path(path)
      path = "/#{path}"
      path.squeeze!('/')
      path.sub!(%r{/+\Z}, '')
      path.gsub!(/(%[a-f0-9]{2})/) { $1.upcase }
      path = '/' if path == ''
      path
    end

    def router
      Rails.application.routes
    end
  end
end
