require 'deprecated_classes'

describe BaseSerializer do
  let :resource do
    double('resource')
  end

  it "should be the correct class" do
    expect(BaseSerializer.new(resource)).to be_a(Xing::ResourceSerializer)
  end
end
