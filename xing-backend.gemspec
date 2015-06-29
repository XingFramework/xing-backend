Gem::Specification.new do |spec|
  spec.name		= "xing-backend"
  spec.version		= "0.0.15"
  author_list = {
    "Evan Dorn" => 'evan@lrdesign.com',
    "Patricia Ho" => 'patricia@lrdesign.com',
    "Hannah Howard" => 'hannah@lrdesign.com',
    "Judson Lester" => 'judson@lrdesign.com'
  }
  spec.authors		= author_list.keys
  spec.email		= spec.authors.map {|name| author_list[name]}
  spec.summary		= "Rails backend classes for the Xing web development framework."
  spec.description	= <<-EndDescription
    Xing is a Rails + AngularJS + Hypermedia web development framework and platform.  This
    gem contains the base code for a backend/rails server in Xing.
  EndDescription

  spec.homepage        = "http://github.com/#{spec.name.downcase}"
  spec.required_rubygems_version = Gem::Requirement.new(">= 0") if spec.respond_to? :required_rubygems_version=

  # Do this: y$@"
  # !!find lib bin doc spec spec_help -not -regex '.*\.\(sw.\|keep\)' -type f  2>/dev/null
  #
  # On OSX:
  # find -E lib bin doc spec spec_help -not -regex '.*\.(sw.|keep)' -type f  2>/dev/null
  spec.files		= %w[
    lib/deprecated_classes.rb
    lib/xing/builders/list_difference_builder.rb
    lib/xing/builders/ordered_list_difference_builder.rb
    lib/xing/builders.rb
    lib/xing/controllers/base.rb
    lib/xing/controllers/root_resources_controller.rb
    lib/xing/engine.rb
    lib/xing/builders/list_difference_builder.rb
    lib/xing/builders/ordered_list_difference_builder.rb
    lib/xing/builders.rb
    lib/xing/mappers/base.rb
    lib/xing/mappers.rb
    lib/xing/serializers/base.rb
    lib/xing/serializers/list.rb
    lib/xing/serializers/paged_list.rb
    lib/xing/serializers/root_resources.rb
    lib/xing/serializers.rb
    lib/xing/services/error_converter.rb
    lib/xing/services/json_tree_lister.rb
    lib/xing/services/locator.rb
    lib/xing/services/snapshot_fetcher.rb
    lib/xing/services/snapshot_writer.rb
    lib/xing/services/locator.rb
    lib/xing/services.rb
    lib/xing-backend.rb
    spec/deprecated_classes/active_model_error_converter_spec.rb
    spec/deprecated_classes/base_serializer_spec.rb
    spec/deprecated_classes/hypermedia_json_mapper_spec.rb
    spec/deprecated_classes/json_tree_lister_spec.rb
    spec/deprecated_classes/list_difference_builder_spec.rb
    spec/deprecated_classes/remote_snapshot_fetcher_spec.rb
    spec/deprecated_classes/resources_serializer_spec.rb
    spec/xing/builders/list_difference_builder_spec.rb
    spec/xing/builders/ordered_list_difference_builder_spec.rb
    spec/xing/controllers/base_spec.rb
    spec/xing/controllers/root_resources_controller_spec.rb
    spec/xing/mappers/base_spec.rb
    spec/xing/serializers/base_spec.rb
    spec/xing/serializers/paged_list_spec.rb
    spec/xing/serializers/root_resources_spec.rb
    spec/xing/services/error_converter_spec.rb
    spec/xing/services/json_tree_lister_spec.rb
    spec/xing/services/snapshot_fetcher_spec.rb
    spec/xing_spec.rb
    spec_help/dummy/app/assets/javascripts/application.js
    spec_help/dummy/app/assets/stylesheets/application.css
    spec_help/dummy/app/controllers/application_controller.rb
    spec_help/dummy/app/helpers/application_helper.rb
    spec_help/dummy/app/views/layouts/application.html.erb
    spec_help/dummy/bin/bundle
    spec_help/dummy/bin/rails
    spec_help/dummy/bin/rake
    spec_help/dummy/bin/setup
    spec_help/dummy/config/application.rb
    spec_help/dummy/config/boot.rb
    spec_help/dummy/config/database.yml
    spec_help/dummy/config/environment.rb
    spec_help/dummy/config/environments/development.rb
    spec_help/dummy/config/environments/production.rb
    spec_help/dummy/config/environments/test.rb
    spec_help/dummy/config/initializers/assets.rb
    spec_help/dummy/config/initializers/backtrace_silencers.rb
    spec_help/dummy/config/initializers/cookies_serializer.rb
    spec_help/dummy/config/initializers/filter_parameter_logging.rb
    spec_help/dummy/config/initializers/inflections.rb
    spec_help/dummy/config/initializers/mime_types.rb
    spec_help/dummy/config/initializers/session_store.rb
    spec_help/dummy/config/initializers/wrap_parameters.rb
    spec_help/dummy/config/locales/en.yml
    spec_help/dummy/config/routes.rb
    spec_help/dummy/config/secrets.yml
    spec_help/dummy/config.ru
    spec_help/dummy/public/404.html
    spec_help/dummy/public/422.html
    spec_help/dummy/public/500.html
    spec_help/dummy/public/favicon.ico
    spec_help/dummy/Rakefile
    spec_help/dummy/README.rdoc
    spec_help/spec_helper.rb
  ]

  spec.licenses = ["MIT"]
  spec.require_paths = %w[lib/]
  spec.rubygems_version = "1.3.5"

  spec.has_rdoc		= false  # TODO
  #spec.extra_rdoc_files = Dir.glob("doc/**/*")
  spec.rdoc_options	= %w{--inline-source }
  spec.rdoc_options	+= %w{--main doc/README }
  spec.rdoc_options	+= ["--title", "#{spec.name}-#{spec.version} Documentation"]


  spec.add_dependency 'rails', "~> 4.2.1"
  spec.add_dependency 'active_model_serializers', "~> 0.9.3"
  spec.add_dependency 'i18n', "~> 0.7"
  spec.add_dependency 'xing_backend_token_auth', "~> 0.1.31"
  spec.add_dependency 'rails-rfc6570', '~> 0.3'
  spec.add_dependency 'typhoeus', "~> 0.7"
  spec.add_dependency 'sidekiq', "~> 3.3"
end
