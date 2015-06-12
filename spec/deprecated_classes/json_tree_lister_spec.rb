require 'deprecated_classes'

describe JsonTreeLister do
  let :models do
    double('models')
  end
  let :serializer do
    double('serializer')
  end

  it "should be the correct class" do
    expect(JsonTreeLister.new(models, serializer)).to be_a(Xing::Services::JsonTreeLister)
  end
end
