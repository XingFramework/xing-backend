module Xing
  module Builders
    class OrderedListDifferenceBuilder < ListDifferenceBuilder
      def map_items
        @new_list = []
        @list_data.each_with_index do |item, index|

          mapper = @mapper_class.new(item[:incoming], item[:locator])

          # Sets association, attributes and position
          @collection << mapper.record
          mapper.perform_mapping
          set_position(mapper.record, index)

          @new_list << mapper
          @errors[index] = mapper.errors[:data] unless mapper.errors[:data].blank?
        end
      end

      def set_position(record, index)
         record.position = index if record.has_attribute?(:position)
      end
    end
  end
end
