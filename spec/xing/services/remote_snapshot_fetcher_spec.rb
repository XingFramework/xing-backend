require 'spec_helper'

describe Xing::Services::SnapshotFetcher do
  describe "if remote succeeds" do
    before do
      begin
        FileUtils.mkdir_p("#{ Rails.root }/spec/fixtures/sitemap_scratch")
        File.delete("#{ Rails.root }/spec/fixtures/sitemap_scratch/test.html")
      rescue
      end
    end

    # This feels like way too much mocking, but dont know how to test without completely
    # turning off selenium
    before do
      response = Typhoeus::Response.new(code: 200, body: "some html content")
      Typhoeus.stub(Rails.application.secrets.snapshot_server['url']).and_return(response)
      expect(Typhoeus::Request).to receive(:new).with(
        Rails.application.secrets.snapshot_server['url'],
        :userpwd => "#{Rails.application.secrets.snapshot_server['user']}:#{Rails.application.secrets.snapshot_server['password']}",
        :params => { :url => "http://www.awesome.com/test" }
      ).and_call_original
    end

    subject :remote_snapshot_fetcher do
      Xing::Services::SnapshotFetcher.new
    end

    it "should read html contents from remote server and output to the file" do
      remote_snapshot_fetcher.perform("http://www.awesome.com", "test")
      content = File.read("#{ Rails.root }/spec/fixtures/sitemap_scratch/test.html")
      expect(content).to eq("some html content")
    end
  end

  describe "if remote fails" do
    before do
      response = Typhoeus::Response.new(code: 500, status_message: "failed", body: "a backtrace")
      Typhoeus.stub(Rails.application.secrets.snapshot_server['url']).and_return(response)
      expect(Typhoeus::Request).to receive(:new).with(
        Rails.application.secrets.snapshot_server['url'],
        :userpwd => "#{Rails.application.secrets.snapshot_server['user']}:#{Rails.application.secrets.snapshot_server['password']}",
        :params => { :url => "http://www.awesome.com/test" }
      ).and_call_original
    end

    let :logger do
      double("Logger")
    end

    subject :remote_snapshot_fetcher do
      Xing::Services::SnapshotFetcher.new.tap do |fetcher|
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
