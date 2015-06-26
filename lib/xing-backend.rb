require 'rails'
require 'xing_backend_token_auth'
require 'rails/rfc6570'
require 'sidekiq'

module Xing
  mattr_accessor :backend_subdomain

  # Configure xing via pattern similar to Rails:
  #
  # Xing.configure do |config|
  #   config.setting =  'value'
  # end
  #
  # Supported settings right now are:
  #   * backend_subdomain (default: 'api')
  def self.configure(&block)
    yield self
  end

  module Controllers
    autoload :Base,                    'xing/controllers/base'

    # NOTE: The rails router expects the the controller to have "Controller" as
    # the suffix of the name, or it complains.
    autoload :RootResourcesController, 'xing/controllers/root_resources_controller'
  end
end

require 'xing/mappers'
require 'xing/engine'
require 'xing/serializers'
require 'xing/services'
require 'xing/builders'
require 'deprecated_classes'
