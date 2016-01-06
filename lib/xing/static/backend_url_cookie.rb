module Xing
  module Static
    class BackendUrlCookie
      def initialize(app, backend_url)
        @backend_url = backend_url
        @app = app
      end

      def call(env)
        status, headers, body = @app.call(env)
        headers["Set-Cookie"] = [(headers["Set-Cookie"]), "lrdBackendUrl=#@backend_url"].compact.join(";") unless @backend_url.nil?
        [ status, headers, body ]
      end
    end
  end
end
