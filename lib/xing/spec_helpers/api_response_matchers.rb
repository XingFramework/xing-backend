module APIResponseMatchers
  extend RSpec::Matchers::DSL

  matcher :reject_as_unprocessable do
    match_unless_raises ActiveSupport::TestCase::Assertion do |response|
      expect(response.status).to eq(422)
    end

    failure_message do |response|
      "Expected response to be a 422: Unprocessable Entity"
    end

    failure_message_when_negated do |source|
      "Expected response not to be a 422: Unprocessable Entity"
    end

    description do
      "should send a 422: Unprocessable Entity status"
    end
  end
end


class RSpec::Core::ExampleGroup
  include APIResponseMatchers
end
