module Xing
  module Builders
    class OrderedListDifferenceBuilder < ListDifferenceBuilder
      def set_position(record, index)
        record.position = index if record.has_attribute?(:position)
      end
    end
  end
end
