module Xing::Services
  # If you want to use the PagedList serializers, but are using resources that
  # aren't actually provided by Kaminari, you can instead feed them to
  # PageWrapper and you should get everything you need
  class PageWrapper
    include Enumerable

    def initialize(list, page_num, total_items, per_page)
      @list, @total_items, @per_page, @page_num = list, total_items, per_page, page_num
    end
    attr_reader :list, :total_items, :per_page, :page_num

    alias current_page page_num
    alias total_count total_items
    alias limit_value per_page

    def total_pages
      (total_items / per_page.to_f).ceil
    end

    def each(*args, &block)
      @list.each(*args, &block)
    end
  end
end
