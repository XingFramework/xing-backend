require 'xing/nominal/secrets_validator'
require 'xing/nominal/database_config_validator'

namespace :dependencies do
  include Xing::Nominal::DependencyUtils

  task :check => [
    :secrets,
    :database_config,
    'redis:running'
  ]
  namespace :check do
    task :tmux => 'dependencies:check' do
      sh_or_fail "which tmux", "tmux is not installed."
      sh_or_fail "which realpath", "realpath is not installed.  Mac users see: http://j.mp/mac_realpath"
    end
  end

  task :secrets do
    env = ENV['RAILS_ENV'] || 'development'
    validator = Xing::Nominal::SecretsValidator.new
    validator.assert_existence
    validator.validate(env)
    validator.report!
  end

  task :database_config do
    env = ENV['RAILS_ENV'] || 'development'
    validator = Xing::Nominal::DatabaseConfigValidator.new
    validator.assert_existence
    validator.validate(env)
    validator.report!
  end

  task :api_host do
    # TODO - if in development, check that the API host resolves
  end

  namespace :redis do
    task :running => :installed do
      sh_or_fail "redis-cli ping", "Redis is not running."
    end
    task :installed do
      sh_or_fail "which redis-cli", "Redis is not installed."
    end
  end


end
