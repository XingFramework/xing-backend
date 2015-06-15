
require 'deprecated_classes'

describe JsonController do
  it "should be the correct class" do
    expect(JsonController.new()).to be_a(Xing::BaseController)
  end
end
