require 'xing/serializers/list'
require 'json_spec'

describe Xing::Serializers::List do
  include JsonSpec::Matchers

  class ItemSerializer < Xing::Serializers::Base
    attributes :name, :position
    def links
      { :self => 'url_for_this_model' }
    end
  end

  class ListSerializer < Xing::Serializers::List
    def item_serializer_class
      ItemSerializer
    end

    def template_link
      "template_url_for_list"
    end

    def self_link
      "url_for_list"
    end
  end

  let :list do
    (1..3).map do |index|
      double("a mock activemodel").tap do |model|
        allow(model).to receive(:read_attribute_for_serialization).with(:name).and_return("Name #{index}!")
        allow(model).to receive(:read_attribute_for_serialization).with(:position).and_return(index)
      end
    end
  end

  let :total_pages do 3 end

  let :serializer do
    ListSerializer.new(list)
  end

  let :json do
    serializer.to_json
  end

  describe 'as_json' do

    it "should have the correct structure" do
      expect(json).to have_json_path('links/self')
      expect(json).to have_json_path('links/template')
      expect(json).to have_json_path('data/')
    end

    it "should generate a JSON with the proper links and self" do
      expect(json).to be_json_eql('"url_for_list"').at_path('links/self')
      expect(json).to be_json_eql('"template_url_for_list"').at_path('links/template')
      expect(json).to be_json_eql('"Name 2!"').at_path('data/1/data/name')
      expect(json).to be_json_eql('2').at_path('data/1/data/position')
      expect(json).to be_json_eql('"url_for_this_model"').at_path('data/1/links/self')
    end

    it "should call the video response serializer" do
      expect(ItemSerializer).to receive(:new).with(list[0], anything)
      expect(ItemSerializer).to receive(:new).with(list[1], anything)
      expect(ItemSerializer).to receive(:new).with(list[2], anything)
      expect(json).to have_json_size(3).at_path('data')
    end
  end
end
