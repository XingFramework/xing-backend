require 'rspec'
require 'rspec/core/formatters/base_formatter'
require 'cadre/rspec3'

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.add_formatter(Cadre::RSpec3::NotifyOnCompleteFormatter)
  config.add_formatter(Cadre::RSpec3::QuickfixFormatter)
end
