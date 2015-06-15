require 'xing/services/snapshot_fetcher'
require 'typhoeus'


describe Xing::Services::SnapshotFetcher do
  let :server_secrets do
    { 'url' => 'http://snapshot-server.com',
      'user' => 'foobar',
      'password' => 'my_password'
    }
  end
  let :mock_hydra    do  double('a hydra object') end
  let :mock_request  do  double('request') end
  let :mock_response do  double('a response') end
  let :fetcher       do
    Xing::Services::SnapshotFetcher.new
  end

  before do
    allow(Rails).to receive_message_chain(:application, :secrets, :snapshot_server)
      .and_return(server_secrets)
    allow(Addressable::URI).to receive(:join).and_return(
      'http://xing-framework.com/backend/documentation.html'
    )
  end

  it "should make a correctly-formatted request to the snapshot server" do
    expect(Typhoeus::Request).to receive(:new).with('http://snapshot-server.com',
          { userpwd: "foobar:my_password",
            params: { url: 'http://xing-framework.com/backend/documentation.html' }
          }
         )
    .and_return(mock_request)
    expect(Typhoeus::Hydra).to receive(:new).and_return(mock_hydra)
    expect(mock_hydra).to    receive(:queue).with(mock_request)
    expect(mock_hydra).to    receive(:run)
    expect(mock_request).to  receive(:response).and_return(mock_response)
    expect(mock_response).to receive(:success?).and_return(true)
    expect(mock_response).to receive(:body).and_return("body of snapshot")
    expect(fetcher).to       receive(:write).with('backend/documentation.html',
                                                  'body of snapshot')
    fetcher.perform('http://xing-framework.com', 'backend/documentation.html' )
  end


end
