require 'xing/serializers/base'

module Xing::Serializers
  class List < Base

    def item_serializer_class
      raise NotImplementedError,
        "subclasses of Xing::Serializers::List must override item_serializer_class to refer to the per-item serializer"
    end

    def item_serializer_options
      {}
    end

    def template_link
      return nil
    end

    def self_link
      raise NotImplementedError,
        "subclasses of Xing::Serializers::List must override self_link to return their own path"
    end

    def as_json_without_wrap(options={})
      object.map do |item|
        item_serializer_class.new(item, item_serializer_options).as_json
      end
    end

    def links
      links = {
        :self => self_link
      }
      links[:template] = template_link unless template_link.nil?
      return links
    end
  end
end
