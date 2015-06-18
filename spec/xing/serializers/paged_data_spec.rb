require 'xing/serializers/paged_data'
require 'json_spec'

describe Xing::Serializers::PagedData do
  include JsonSpec::Matchers

  class ItemSerializer < Xing::Serializers::Base
    attributes :name, :position
    def links
      { :self => 'url_for_this_model' }
    end
  end

  class PageSerializer < Xing::Serializers::PagedData
    def item_serializer_class
      ItemSerializer
    end

    # Structures a testable "link" text
    def page_link(options)
      page_num = options.delete(:page)
      "page_link:#{page_num}-#{options.keys.join(",")}"
    end

    def self_link
      "url_for_this_page"
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
    PageSerializer.new(list, page_num, total_pages)
  end

  let :json do
    serializer.to_json
  end

  describe 'as_json' do
    let :page_num do 1 end

    it "should have the correct structure" do
      expect(json).to have_json_path('links/self')
      expect(json).to have_json_path('links/next')
      expect(json).to have_json_path('links/previous')
      expect(json).to have_json_path('data/')
    end

    it "should generate a JSON with the proper links and self" do
      expect(json).to be_json_eql('"url_for_this_page"').at_path('links/self')
      expect(json).to be_json_eql('"page_link:2-"').at_path('links/next')
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

  describe 'links' do
    context 'first page' do
      let :page_num do
        1
      end

      it 'should not have a previous link' do
        expect(serializer.previous_link).to be_nil
      end

      it 'should have a next link' do
        expect(serializer.next_link).to_not be_nil
      end
    end

    context 'last page' do
      let :page_num do
        3
      end

      it 'should have a previous link' do
        expect(serializer.previous_link).to_not be_nil
      end

      it 'should not have a next link' do
        expect(serializer.next_link).to be_nil
      end
    end

    context 'neither first page or last page' do
      let :page_num do
        2
      end

      it 'should have a previous link' do
        expect(serializer.previous_link).to_not be_nil
      end

      it 'should have a next link' do
        expect(serializer.next_link).to_not be_nil
      end
    end
  end
end
