require 'xing/snapshot/fetcher'
require 'file-sandbox'

describe Xing::Snapshot::Fetcher do
  include FileSandbox

  let :server_secrets do
    { 'url' => 'http://snapshot-server.com',
      'user' => 'foobar',
      'password' => 'my_password'
    }
  end

  before do
    allow(Rails).to receive_message_chain(:application, :secrets, :snapshot_server).and_return(server_secrets)
    allow(Rails).to receive(:root).and_return(@sandbox.root)
  end

  describe "if remote succeeds" do
    before do
      begin
        #FileUtils.mkdir_p("#{ Rails.root }/spec/fixtures/sitemap_scratch")
        #File.delete("#{ Rails.root }/spec/fixtures/sitemap_scratch/test.html")
      rescue
      end
    end

    # This feels like way too much mocking, but dont know how to test without
    # completely
    # turning off selenium
    before do
      response = Typhoeus::Response.new(code: 200, body: "some html content")
      Typhoeus.stub(server_secrets['url']).and_return(response)
      expect(Typhoeus::Request).to receive(:new).with(
        server_secrets['url'],
        :userpwd => "#{server_secrets['user']}:#{server_secrets['password']}",
        :params => { :url => "http://www.awesome.com/test" }
      ).and_call_original
    end

    subject :remote_snapshot_fetcher do
      Xing::Snapshot::Fetcher.new
    end

    it "should read html contents from remote server and output to the file" do
      remote_snapshot_fetcher.perform("http://www.awesome.com", "test")
      content = File.read("public/frontend_snapshots/test.html")
      expect(content).to eq("some html content")
    end
  end

  describe "if remote fails" do
    before do
      response = Typhoeus::Response.new(code: 500, status_message: "failed", body: "a backtrace")
      Typhoeus.stub(server_secrets['url']).and_return(response)
      expect(Typhoeus::Request).to receive(:new).with(
        server_secrets['url'],
        :userpwd => "#{server_secrets['user']}:#{server_secrets['password']}",
        :params => { :url => "http://www.awesome.com/test" }
      ).and_call_original
    end

    let :logger do
      double("Logger")
    end

    subject :remote_snapshot_fetcher do
      Xing::Snapshot::Fetcher.new.tap do |fetcher|
        allow(fetcher).to receive(:logger).and_return(logger)
      end
    end

    it "should read html contents from remote server and output to the file" do
      expect(logger).to receive(:warn).with(/failed/)
      expect(logger).to receive(:warn).with(/a backtrace/)
      expect do
        remote_snapshot_fetcher.perform("http://www.awesome.com", "test")
      end.to raise_error(/Query.*failed/)
    end
  end
end
