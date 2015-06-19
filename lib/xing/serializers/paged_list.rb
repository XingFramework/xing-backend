require 'xing/serializers/list'

module Xing::Serializers
  class PagedList < List
    def initialize(list, page_num, total_pages, options = {})
      @page_num = page_num.to_i
      @total_pages = total_pages

      super(list, options)
    end

    attr_reader :page_num, :total_pages

    def page_link(options)
      raise NotImplemented,
        "subclasses of Xing::Serializers::PagesData must override page_link to return the URL of a page based on a :page => Integer() hash"
    end

    def next_link
      page_link({page: page_num + 1}) unless page_num == total_pages
    end

    def previous_link
      page_link({page: page_num - 1}) unless page_num == 1
    end

    def links
      {
        :self => self_link,
        :next => next_link,
        :previous => previous_link
      }
    end
  end
end
