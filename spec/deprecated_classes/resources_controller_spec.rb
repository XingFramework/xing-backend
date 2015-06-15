
require 'deprecated_classes'

describe ResourcesController, :type => :deprecation do
  it "should be the correct class" do
    expect(ResourcesController.new()).to be_a(Xing::RootResourcesController)
  end
end
