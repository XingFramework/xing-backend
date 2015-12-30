$RAW_SELENIUM_WAIT = 5
if ENV["CI_SERVER"] == "yes"
  puts "Setting up longer timeouts for CI"
  Capybara.default_wait_time = 30
  $RAW_SELENIUM_WAIT = 30
end
