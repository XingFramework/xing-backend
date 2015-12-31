require 'xing/serializers/paged_index'
require 'xing/services/paged_wrapper'

describe Xing::Serializers::PagedIndex do
  class PageIndexSerializer < Xing::Serializers::PagedIndex
    def self_link
      "url_for_index"
    end

    def template_link
      Addressable::Template.new("/page{/page}")
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

  let :page_num do 1 end

  let :total_pages do 3 end

  let :total_items do
    total_pages * per_page - 1
  end

  let :json do
    serializer.to_json
  end

  describe 'as_json' do
    let :serializer do
      PageIndexSerializer.new(Xing::Services::PagedWrapper.new(list, page_num, total_items, per_page))
    end

    it "should generate a JSON with the proper links and self" do
      expect(parse_json(json, "links/self")).to eq("url_for_index")
      expect(parse_json(json, "links/first")).to eq("/page/1")
      expect(parse_json(json, "links/last")).to eq("/page/3")
      expect(parse_json(json, "data/per_page")).to eq(per_page)
      expect(parse_json(json, "data/total_pages")).to eq(total_pages)
      expect(parse_json(json, "data/total_items")).to eq(total_items)
    end
  end

  describe 'using Kaminari' do
    let :kaminari_list do
      Kaminari.paginate_array((list * 3)[0..-2]).page(1).per(per_page)
    end

    let :serializer do
      PageIndexSerializer.new(kaminari_list)
    end

    it "should generate a JSON with the proper links and self" do
      expect(parse_json(json, "links/self")).to eq("url_for_index")
      expect(parse_json(json, "links/first")).to eq("/page/1")
      expect(parse_json(json, "links/last")).to eq("/page/3")
      expect(parse_json(json, "data/per_page")).to eq(per_page)
      expect(parse_json(json, "data/total_pages")).to eq(total_pages)
      expect(parse_json(json, "data/total_items")).to eq(total_items)
    end
  end
end
