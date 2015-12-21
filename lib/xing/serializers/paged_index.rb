require 'xing/serializers/base'
require 'xing/serializers/paged'

module Xing::Serializers
  # Serializes the reference index of a long paginated list. We assume the
  # interface provided by Kaminari: the object to be serialized needs to
  # respond to:
  #
  #   current_page, limit_value, total_pages, total_count, each(and various
  #   Enumerable methods)

  class PagedIndex < Base
    include Paged

    def self.total_called(name)
      attributes name
      alias_method name, :total_items
    end

    attributes :per_page, :total_pages, :total_items

    def total_items
      object.total_count
    end

    def per_page
      object.limit_value
    end

    def self_link
      raise NotImplementedError,
        "subclasses of Xing::Serializers::PagedIndex must override self_link to provide a path URL to themselves"
    end
  end
end
