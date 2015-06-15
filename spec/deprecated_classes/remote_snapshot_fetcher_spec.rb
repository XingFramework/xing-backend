
require 'deprecated_classes'

describe RemoteSnapshotFetcher do
  it "should be the correct class" do
    expect(RemoteSnapshotFetcher.new()).to be_a(Xing::Services::SnapshotFetcher)
  end
end
