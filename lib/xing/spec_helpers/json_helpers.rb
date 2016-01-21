module Xing::JsonSpecHelpers
  def be_json_string(str)
    be_json_eql("\"#{str}\"")
  end
end

RSpec.configure do |config|
  config.include Xing::JsonSpecHelpers
end
