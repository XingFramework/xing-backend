module Xing
  module Nominal
    module DependencyUtils
      require 'pp'
      def sh_or_fail(command, fail_message)
        sh command do |ok, result|
          dep_fail fail_message unless ok
        end
      end

      def dep_fail(fail_message, details = nil)
        message = "Dependency Failed: " + fail_message
        message += "  (Details below):\n#{details.pretty_inspect}" if details
        abort red(message)
      end

      def red(string)
        "\e[1;31m#{string}\e[0m"
      end

      def dep_success(message)
        puts message
      end
    end
  end
end
