
require 'deprecated_classes'

describe ResourcesSerializer do
  let :resource do
    double('hash_of_links')
  end

  it "should be the correct class" do
    expect(ResourcesSerializer.new(resource)).to be_a(Xing::Serializers::RootResources)
  end
end
