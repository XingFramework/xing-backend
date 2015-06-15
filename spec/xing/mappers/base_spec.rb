require 'xing/mappers/base'

describe Xing::Mappers::Base do
  it "should exist" do
    expect(Xing::Mappers::Base).to be_a(Module)
  end

  context "subclasses" do
    let :record do
      double("some record").tap do |obj|
        allow(obj).to receive(:save).and_return(true)
      end
    end
    let :json do
      { 'links'=> {},
        'data'=> { some: "value"}
      }
    end

    before do
      stub_const("ActiveModelErrorConverter", double('error converter')).tap do |stub|
        allow(stub).to receive_message_chain(:new, :convert).and_return({})
      end
    end

    it "should error if it doesn't have an update_record method and a record_class" do
      class MyMapper < Xing::Mappers::Base
      end

      mapper = MyMapper.new(json)
      mapper.record = record

      expect do
        mapper.save
      end.to raise_error
    end

    it "shouldn't error if it does have an update_record and a record_class method" do
      class MyBetterMapper < Xing::Mappers::Base
        def update_record
        end
        def record_class
          Object
        end
      end

      mapper = MyBetterMapper.new(json)
      mapper.record = record

      expect do
        mapper.save
      end.not_to raise_error
    end
  end

end
