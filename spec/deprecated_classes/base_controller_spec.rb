
require 'deprecated_classes'

describe BaseController do
  it "should be the correct class" do
    expect(BaseController.new()).to be_a(Xing::BaseController)
  end
end
