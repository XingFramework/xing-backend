require 'xing/serializers/base'
require 'json_spec'

describe Xing::Serializers::Base do
  include JsonSpec::Matchers

  let :resource do
    double("a mock activemodel").tap do |model|
      allow(model).to receive(:read_attribute_for_serialization).with(:name).and_return("My Name!")
      allow(model).to receive(:read_attribute_for_serialization).with(:position).and_return(2)
    end
  end


  context "a subclass" do

    class MySerializer < Xing::Serializers::Base
      attributes :name, :position
      def links
        { :self => 'url_for_this_model' }
      end
    end

    it "should generate a JSON with the proper links and self" do
      json = MySerializer.new(resource).to_json
      expect(json).to be_json_eql('"url_for_this_model"').at_path('links/self')
      expect(json).to be_json_eql('"My Name!"').at_path('data/name')
      expect(json).to be_json_eql('2').at_path('data/position')
    end
  end
end
