require 'deprecated_classes'

describe ListDifferenceBuilder, :type => :deprecation do
  let :list_data do
    double('list_data')
  end

  let :collection do
    double('many.things')
  end

  let :mapper do
    double('ThingMapper')
  end

  it "should be the correct class" do
    expect(ListDifferenceBuilder.new(list_data, mapper)).to be_a(Xing::Builders::OrderedListDifferenceBuilder)
  end
end
