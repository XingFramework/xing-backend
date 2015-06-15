source "https://rubygems.org"

gem 'rails', "~> 4.2.0"
gem 'active_model_serializers'
gem 'i18n'
gem 'devise_token_auth', :github => 'lrdesign/devise_token_auth'
gem 'rails-rfc6570', '~> 0.3'
gem 'typhoeus'
gem 'sidekiq'

group :development, :test do
  gem 'byebug'
  gem 'cadre'
  gem 'corundum'
  gem 'sqlite3'
  #gem 'json_spec'
end

group :test do
  gem 'codeclimate-test-reporter', require: nil
  gem 'actionpack'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'fuubar', "~> 2.0.0.rc1"
end

gemspec :name => "xing-backend" #points to default 'gem.gemspec'
