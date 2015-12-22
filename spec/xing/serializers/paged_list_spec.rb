require 'xing/serializers/paged_list'

describe Xing::Serializers::PagedList do
  class ItemSerializer < Xing::Serializers::Base
    attributes :name, :position
    def links
      { :self => 'url_for_this_model' }
    end
  end

  class PageSerializer < Xing::Serializers::PagedList
    def item_serializer_class
      ItemSerializer
    end

    def template_link
      Addressable::Template.new("/page{/page}")
    end

    def self_link
      "url_for_this_page"
    end
  end

  let :per_page do
    3
  end

  let :list do
    (1..per_page).map do |index|
      double("a mock activemodel").tap do |model|
        allow(model).to receive(:read_attribute_for_serialization).with(:name).and_return("Name #{index}!")
        allow(model).to receive(:read_attribute_for_serialization).with(:position).and_return(index)
      end
    end
  end

  let :total_pages do 3 end

  let :total_items do
    total_pages * per_page - 1
  end

  let :serializer do
    PageSerializer.new(Xing::Services::PageWrapper.new(list, page_num, total_items, per_page))
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
      expect(parse_json(json, "links/self")).to eq("url_for_this_page")
      expect(parse_json(json, "links/next")).to eq("/page/2")
      expect(parse_json(json, "links/first")).to eq("/page/1")
      expect(parse_json(json, "links/last")).to eq("/page/3")
      expect(parse_json(json, "data/1/data/name")).to eq("Name 2!")
      expect(parse_json(json, "data/1/data/position")).to eq(2)
      expect(parse_json(json, "data/1/links/self")).to eq("url_for_this_model")
    end

    it "should call the video response serializer" do
      expect(ItemSerializer).to receive(:new).with(list[0], anything)
      expect(ItemSerializer).to receive(:new).with(list[1], anything)
      expect(ItemSerializer).to receive(:new).with(list[2], anything)
      expect(json).to have_json_size(3).at_path('data')
    end
  end

  describe 'using Kaminara' do
    let :kaminari_list do
      Kaminari.paginate_array(list * 3).page(1).per(per_page)
    end

    let :serializer do
      PageSerializer.new(kaminari_list)
    end

    let :page_num do 1 end

    it "should have the correct structure" do
      expect(json).to have_json_path('links/self')
      expect(json).to have_json_path('links/next')
      expect(json).to have_json_path('links/previous')
      expect(json).to have_json_path('data/')
    end

    it "should generate a JSON with the proper links and self" do
      expect(parse_json(json, "links/self")).to eq("url_for_this_page")
      expect(parse_json(json, "links/next")).to eq("/page/2")
      expect(parse_json(json, "links/first")).to eq("/page/1")
      expect(parse_json(json, "links/last")).to eq("/page/3")
      expect(parse_json(json, "data/1/data/name")).to eq("Name 2!")
      expect(parse_json(json, "data/1/data/position")).to eq(2)
      expect(parse_json(json, "data/1/links/self")).to eq("url_for_this_model")
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
