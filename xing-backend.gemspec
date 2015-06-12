Gem::Specification.new do |spec|
  spec.name		= "xing-backend"
  spec.version		= "0.0.1"
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
  # !!find lib bin doc spec spec_help -not -regex '.*\.sw.' -type f 2>/dev/null
  spec.files		= %w[
    lib/xing.rb
  ]
    #spec/railtie.rb
    #spec/middleware.rb
    #spec_help/spec_helper.rb
    #spec_help/gem_test_suite.rb
    #spec_help/railtie-help.rb
    #spec_help/file-sandbox.rb

    #certs/ca-certificates.crt
  #]

  spec.test_file        = "spec_help/gem_test_suite.rb"
  spec.licenses = ["MIT"]
  spec.require_paths = %w[lib/]
  spec.rubygems_version = "1.3.5"

  spec.has_rdoc		= true
  #spec.extra_rdoc_files = Dir.glob("doc/**/*")
  spec.rdoc_options	= %w{--inline-source }
  spec.rdoc_options	+= %w{--main doc/README }
  spec.rdoc_options	+= ["--title", "#{spec.name}-#{spec.version} Documentation"]

  #spec.add_dependency("", "> 0")
  spec.add_development_dependency("rspec-rails", "~> 3.2")
  spec.add_development_dependency("rspec", "~> 3.2")
  spec.add_development_dependency("json_spec")
  spec.add_development_dependency 'combustion', '~> 0.5.3'
  

  spec.add_runtime_dependency 'rails', "~> 4.2.0"
  spec.add_runtime_dependency 'active_model_serializers'
  spec.add_runtime_dependency 'i18n'
  spec.add_runtime_dependency 'devise_token_auth'


  #spec.post_install_message = "Thanks for installing my gem!"
end

