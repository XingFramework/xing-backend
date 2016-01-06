module Xing
  module Static
    require 'logger'
    class Logger < ::Logger
      # needed to use stdlib logger with Rack < 1.6.0
      def write(msg)
        self.<<(msg)
      end
    end
  end
end
