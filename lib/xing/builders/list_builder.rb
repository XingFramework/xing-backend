require 'xing/services/locator'

module Xing
  module Builders
    class ListBuilder
      include Services::Locator

      # list_data is is an array of JSON objects passed in by the mapper (the new list of records)
      def initialize(list_data, mapper_class)
        @list_data = list_data
        @mapper_class = mapper_class

        @errors = Hash.new { |hash, key| hash[key] = {} }
      end

      attr_reader :errors

      def locator_for(data)
        route_to(data[:links][:self])[:id].to_i unless (data[:links] || {})[:self].blank?
      end

      def build
        @new_list = []
        @list_data.each_with_index do |data, index|

          mapper = @mapper_class.new(data, locator_for(data))

          mapper.perform_mapping
          set_position(mapper.record, index)

          @new_list << mapper.record
          @errors[index] = mapper.errors[:data] unless mapper.errors[:data].blank?
        end
        @new_list
      end

      def set_position(record, index)
        # position is not set in list builder
      end
    end
  end
end
