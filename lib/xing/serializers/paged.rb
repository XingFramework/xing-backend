module Xing::Serializers
  module Paged
    def template_link
      raise NotImplementedError,
        "subclasses of Xing::Serializers::PagedList must override template_link to provide a path URL template with a single :page field\n" +
        "usually you can do something like my_resource_path_rfc6570 (sometimes you'll need to also call .partial_expand)\n\n" +
        "If you prefer, you can return nil from template_link and override page_link to do something else."
    end

    def total_pages
      object.total_pages
    end

    def first_link
      page_link({page: 1})
    end

    def last_link
      page_link({page: total_pages})
    end

    def page_link(options)
      template_link.expand(options)
    end

    def links
      {
        :self => self_link,
        :first => first_link,
        :last => last_link,
        :template => template_link
      }
    end
  end
end
