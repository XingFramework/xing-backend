require 'spec_helper'

describe Xing::Builders::OrderedListDifferenceBuilder do

  let :builder do
    Xing::Builders::OrderedListDifferenceBuilder.new(list_data, collection, mapper_class)
  end

  let :mapper_class do
    double("ItemMapper")
  end

  let :mapper_instance do
    double("mapper")
  end

  let :collection do
    [double("Relation AR Object id: 1"), double("Relation AR Object id: 2"), double("Relation AR Object id: 3")]
  end

  let :new_ar_object do
    double("New Relation AR Object")
  end

  let :updated_ar_object do
    double("Updated AR Object")
  end

  let :existing_ids do
    [1,2,3]
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

  let :new_list_data do
    [
      {
        locator: 1,
        incoming: {
          links: {
            self: "/somethings/1"
          },
          data: {
            stuff: "some updated stuff"
          }
        }
      },
      {
        locator: nil,
        incoming: {
          links: {
            self: ""
          },
          data: {
            stuff: "some new stuff"
          }
        }
      }
    ]
  end

  it "should initialize and assign list_data, collection, mapper class and errors" do
    expect(builder.instance_variable_get('@list_data')).to eq(list_data)
    expect(builder.instance_variable_get('@collection')).to eq(collection)
    expect(builder.instance_variable_get('@mapper_class')).to eq(mapper_class)
    expect(builder.instance_variable_get('@errors')).to eq({})
  end

  describe "#sort_json_items" do
    before :each do
      allow(collection).to receive(:map).and_return(existing_ids)
      allow(builder).to receive(:locator_for).and_return(1)
      builder.sort_json_items
    end

    it "should create a list of existing ids" do
      expect(builder.instance_variable_get('@existing_ids')).to eq(existing_ids)
    end

    it "should insert index and locator into the item data" do
      expect(builder.instance_variable_get('@list_data')).to eq(new_list_data)
    end

    it "should find the ids to delete" do
      expect(builder.instance_variable_get('@delete_ids')).to eq([2,3])
    end
  end

  describe "#set_locator" do

    it "should be nil if links is empty" do
      data = { links: {}, data: { text:"bs" } }
      expect(builder.set_locator(data)).to be_nil
    end

    it "should be nil if links/self is empty" do
      data = { links: {self: ""}}
      expect(builder.set_locator(data)).to be_nil
    end

    it "should set locator if links/self is present" do
      data = { links: {self: "some_link/1/something"}}
      allow(builder).to receive(:locator_for).and_return(1)

      expect(builder.set_locator(data)).to eq(1)
    end
  end

  describe "#map_items" do
    before :each do
      builder.instance_variable_set('@list_data', new_list_data)
      allow(mapper_class).to receive(:new).and_return(mapper_instance)
      allow(mapper_instance).to receive(:record).and_return(new_ar_object, new_ar_object, updated_ar_object, updated_ar_object)
      allow(mapper_instance).to receive(:perform_mapping)
      allow(new_ar_object).to receive(:has_attribute?).with(:position).and_return(false)
      allow(updated_ar_object).to receive(:has_attribute?).with(:position).and_return(false)
    end

    context "successful" do
      it "should create a new ar list" do
        allow(mapper_instance).to receive(:errors).and_return({})
        builder.map_items

        expect(builder.instance_variable_get('@new_list')).to match_array([mapper_instance, mapper_instance])
      end
    end

    context "with errors" do
      it "should add to the error hash with the correct index" do
        allow(mapper_instance).to receive(:errors).and_return({}, {data: {type: "I would do anything for love", message: "but I won't do that"}}, {data: {type: "I would do anything for love", message: "but I won't do that"}})
        builder.map_items

        expect(builder.instance_variable_get('@errors')).to eq({1=>{:type=>"I would do anything for love", :message=>"but I won't do that"}})
      end
    end
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
      allow(collection).to receive(:map).and_return(existing_ids)
      allow(builder).to receive(:locator_for).and_return(1)
      allow(mapper_class).to receive(:new).and_return(mapper_instance)
      allow(mapper_instance).to receive(:record).and_return(new_ar_object, new_ar_object, updated_ar_object, updated_ar_object)
      allow(mapper_instance).to receive(:perform_mapping)
      allow(new_ar_object).to receive(:has_attribute?).with(:position).and_return(false)
      allow(updated_ar_object).to receive(:has_attribute?).with(:position).and_return(false)
    end

    context "successful" do
      before :each do
        allow(mapper_instance).to receive(:errors).and_return({})
      end

      it "should return a hash with save keys" do
        expect(builder.build[:save]).to match_array([mapper_instance, mapper_instance])
      end

      it "should return a hash with delete keys" do
        expect(builder.build[:delete]).to match_array([2,3])
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
