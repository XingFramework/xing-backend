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

    it { is_expected.to be_present}
    it { is_expected.to have_json_path('links/page')}
    it { is_expected.to have_json_path('links/menus')}
  end
end
