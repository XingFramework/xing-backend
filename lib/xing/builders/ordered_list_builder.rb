module Xing
  module Builders
    class OrderedListBuilder < ListBuilder
      def set_position(record, index)
        record.position = index if record.has_attribute?(:position)
      end
    end
  end
end
