require 'xing'

describe Xing::RootResourcesController, :type => :controller do
  it "should exist" do
    expect(Xing::RootResourcesController).not_to be_nil
  end


  describe "responding to GET index" do
    let :serializer do
      double(Xing::Serializers::RootResources)
    end

    it "should render all routes as json" do
      Xing::Serializers::RootResources.should_receive(:new).and_return(:serializer)
      get :index
      expect(assigns[:resources][:resources]).to be_a_kind_of(Addressable::Template)
    end
  end

end
