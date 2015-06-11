require 'rails'

module Xing

  class Railtie < Rails::Railtie
    initializer 'xing autoload', :before => :set_autoload_paths do |app|
      # Include the deprecated old constants
      config.autoload_paths += Dir[ Rails.root.join("lib", "framework", "**")]

      # this line for the new, namespaced framework files
      config.autoload_paths += Dir[ Rails.root.join("lib", "framework", "xing","**")]
    end
  end
end

require 'xing/resource_mapper'
