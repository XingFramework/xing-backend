module Xing
  module Serializers
    class RootResources < Base
      def links
        object
      end
    end
  end
end
