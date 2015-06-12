require 'xing/serializers/root_resources'

describe Xing::Serializers::RootResources do
  let :resources do
    {
      :page => "/pages/{url_slug}",
      :menus => "menus"
    }
  end

  describe 'as_json' do
    subject :json do
      Xing::Serializers::RootResources.new(resources).to_json
    end

    it { should be_present}
    it { should have_json_path('links/page')}
    it { should have_json_path('links/menus')}
  end
end
