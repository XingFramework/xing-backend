require 'selenium-webdriver'
require 'xing/snapshot/site_snapshot'
require 'xing/snapshot/writer'

module Xing
  module Snapshot
    class LocalSiteSnapshot < SiteSnapshot
      include Writer

      def initialize(url)
        super(url)
        @wait = Selenium::WebDriver::Wait.new
      end

      def setup
        @driver = Selenium::WebDriver.for :chrome
      end
      attr_accessor :driver, :wait

      def teardown
        @driver.close
      end

      def fetch(url, path)
        @driver.navigate.to(url+path)
        # better way to wait till javascript complete?
        @wait.until do
          @driver.execute_script("return window.frontendContentLoaded == true;")
        end
        element = @driver.find_element(:tag_name, "html")
        html = element.attribute("outerHTML")
        write(path, html)
      end
    end

  end
end
