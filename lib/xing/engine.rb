module Xing
  class Engine < ::Rails::Engine
    isolate_namespace Xing

    rake_tasks do
      load "xing/tasks/all.rake"
    end

    paths.add "app/serializers", eager_load: true, autoload: true
    paths.add "lib", autoload: true

    config.generators do |g|
      g.test_framework :rspec
    end

    # The ErrorConverter leverages (abuses?) the I18n mechanism to translate
    # ActiveModel validation errors into Xing JSON resource errors.  Here we
    # need to make sure the locales file for language 'json' is loaded for
    # I18n.
    initializer 'xing errors locales path' do
      I18n.load_path += Dir[File.join(File.dirname(__FILE__), '..', 'config', 'locales', '*.{rb,yml}')]
    end

    # Set the backend subdomain if it hasn't been configured by the user.
    initializer 'set subdomain' do
      Xing.configure do |xng_config|
        xng_config.backend_subdomain ||= 'api'
      end
    end
  end
end
