require 'static-app'

Capybara.configure do |capy|
  backend_server = Capybara::Server.new(Capybara.app)
  backend_server.boot
  puts "Rails API server started on #{backend_server.host}:#{backend_server.port}"
  ActionMailer::Base.default_url_options[:host] = "#{backend_server.host}:#{backend_server.port}"
  Capybara.app = APP_MODULE::StaticApp.build("../frontend/bin", backend_server.port)
  RSpec.configure do |config|
    config.waterpig_clearable_logs << 'test_static'
  end
end
