require 'xing/services/locator'

module Xing
  module Builders
    class ListDifferenceBuilder
      include Services::Locator

      # list_data is is an array of JSON objects passed in by the mapper (the new list of records)
      # collection is the ActiveRecord collection of existing records (i.e. person.pets, rainbow.colors, book.chapters)
      def initialize(list_data, collection, mapper_class)
        @list_data = list_data
        @collection = collection
        @mapper_class = mapper_class

        @errors = Hash.new { |hash, key| hash[key] = {} }
      end

      attr_reader :errors

      def build
        sort_json_items
        map_items

        { save: @new_list, delete: @delete_ids }
      end

      def sort_json_items
        @existing_ids = @collection.map{|item| item.send(@mapper_class.locator_attribute_name)}

        @list_data = @list_data.map do |data|
          { :locator => set_locator(data), :incoming => data}
        end

        @delete_ids = @existing_ids - @list_data.map { |item| item[:locator] }
      end

      def set_locator(data)
        locator_for(data) unless (data[:links] || {})[:self].blank?
      end

      def locator_for(data)
       Xing::Services::Locator.route_to(data[:links][:self])[:id].to_i
      end

      def map_items
        @new_list = []
        @list_data.each_with_index do |item, index|

          mapper = @mapper_class.new(item[:incoming], item[:locator])

          # Sets association, attributes
          @collection << mapper.record
          mapper.perform_mapping

          @new_list << mapper
          @errors[index] = mapper.errors[:data] unless mapper.errors[:data].blank?
        end
      end
    end
  end
end
