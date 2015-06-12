require 'rails'

module Xing

  class Railtie < Rails::Railtie
    initializer 'xing errors locales path' do
      I18n.load_path += Dir[File.join(File.dirname(__FILE__), 'config', 'locales', '*.{rb,yml}')]
    end
    initializer 'xing autoload', :before => :set_autoload_paths do |app|


      # Commented out pending discovery if we actually need this config.
      #
      #config.autoload_paths += Dir[ Rails.root.join("lib", "framework", "xing","**")]
    end
  end
end

require 'xing/resource_mapper'
require 'xing/resource_serializer'
require 'xing/services'
