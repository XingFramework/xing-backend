require 'deprecated_classes'

describe ActiveModelErrorConverter, :type => :deprecation do
  let :resource do
    double('resource')
  end

  it "should be the correct class" do
    expect(ActiveModelErrorConverter.new(resource)).to be_a(Xing::Services::ErrorConverter)
  end
end
