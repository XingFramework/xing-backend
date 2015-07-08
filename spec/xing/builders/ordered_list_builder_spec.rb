require 'spec_helper'

describe Xing::Builders::OrderedListBuilder do

  let :builder do
    Xing::Builders::OrderedListBuilder.new(list_data, mapper_class)
  end

  let :mapper_class do
    double("ItemMapper")
  end

  let :mapper_instance do
    double("mapper")
  end

  let :new_ar_object do
    double("New Relation AR Object")
  end

  let :updated_ar_object do
    double("Updated AR Object")
  end

  let :list_data do
    [
      {
        links: {
          self: "/somethings/1"
        },
        data: {
          stuff: "some updated stuff"
        }
      },
      {
        links: {
          self: ""
        },
        data: {
          stuff: "some new stuff"
        }
      }
    ]
  end

  it "initialize" do
    expect(builder.instance_variable_get('@list_data')).to eq(list_data)
    expect(builder.instance_variable_get('@mapper_class')).to eq(mapper_class)
    expect(builder.instance_variable_get('@errors')).to eq({})
  end

  describe "#set_position" do

    it "should update the position if the record has a position attribute" do
      allow(new_ar_object).to receive(:has_attribute?).with(:position).and_return(true)
      expect(new_ar_object).to receive(:position=).with(1)

      builder.set_position(new_ar_object, 1)
    end

    it "should not blow up if the record does not have a position attribute" do
      allow(new_ar_object).to receive(:has_attribute?).with(:position).and_return(false)
      expect(new_ar_object).to_not receive(:position=)

      builder.set_position(new_ar_object, 1)
    end
  end

  describe "#build" do
    before :each do
      allow(builder).to receive(:locator_for).and_return(1)
      allow(mapper_class).to receive(:new).with(list_data[0], 1).and_return(mapper_instance)
      allow(mapper_class).to receive(:new).with(list_data[1], 1).and_return(mapper_instance)
      allow(mapper_instance).to receive(:record).and_return(new_ar_object, new_ar_object, updated_ar_object, updated_ar_object)
      allow(mapper_instance).to receive(:perform_mapping)
      allow(new_ar_object).to receive(:has_attribute?).with(:position).and_return(false)
      allow(updated_ar_object).to receive(:has_attribute?).with(:position).and_return(false)
    end

    context "successful" do
      before :each do
        allow(mapper_instance).to receive(:errors).and_return({})
      end

      it "should return array of AR records" do
        expect(builder.build).to match_array([new_ar_object, updated_ar_object])
      end
    end

    context "with errors" do
      before :each do
        allow(mapper_instance).to receive(:errors).and_return({data: {type: "I would do anything for love", message: "but I won't do that"}}, {data: {type: "I would do anything for love", message: "but I won't do that"}}, {})
        builder.build
      end

      it "should return errors" do
        expect(builder.errors).to eq({0=>{:type=>"I would do anything for love", :message=>"but I won't do that"}})
      end
    end
  end
end
