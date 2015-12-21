require 'xing/serializers/list'
require 'xing/serializers/paged'

module Xing::Serializers

  # Serializes a single page of a long paginated list. We assume the interface
  # provided by Kaminari: the object to be serialized needs to respond to:
  #
  #   current_page, limit_value, total_pages, total_count, each(and various
  #   Enumerable methods)

  class PagedList < List
    include Paged

    def page_num
      object.current_page
    end

    def next_link
      page_link({page: page_num + 1}) unless page_num == total_pages
    end

    def previous_link
      page_link({page: page_num - 1}) unless page_num == 1
    end

    def links
      super.merge(
                  :next => next_link,
                  :previous => previous_link
                 )
    end
  end
end
