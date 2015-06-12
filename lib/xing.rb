require 'rails'

module Xing
  mattr_accessor :backend_subdomain

  class Engine < ::Rails::Engine
    isolate_namespace Xing

    config.generators do |g|
      g.test_framework :rspec
    end

    initializer 'xing errors locales path' do
      I18n.load_path += Dir[File.join(File.dirname(__FILE__), 'config', 'locales', '*.{rb,yml}')]
    end

    initializer 'set subdomain' do
      # Set the backend subdomain if it hasn't been configured by the user.
      Xing.configure do |xng_config|
        xng_config.backend_subdomain ||= 'api'
      end
    end

  end

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
end

require 'xing/mappers'
require 'xing/serializers'
require 'xing/services'
