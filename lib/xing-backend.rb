require 'rails'

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
end

require 'xing/engine'
require 'xing/mappers'
require 'xing/serializers'
require 'xing/services'
