require 'rails'
require 'active_model_serializers'

module Xing
  module Serializers

    # The base class for all Xing serializers that produce
    # Xing Hypermedia JSON resources.  In general, subclasses
    # of Xing::Serializers::Base should:
    #
    #   * Define a links method that returns a hash of hypermedia links to
    #     related resources
    #
    #   * Specify the attributes (via the ActiveModel::Serializers 'attributes'
    #     class method) that will be copied into the data: block
    #     of the generated resource.
    #
    #   * Define methods for any attributes that do not exist as plain attributes
    #     in the ActiveModel being serialized.  Note that this may (and often will) include
    #     calling other serializers on related resources or other data, in order to
    #     generate embedded resources.
    #
    # Xing serializers descend from ActiveModel::Serializer and are typically
    # instantiated with an instance of an ActiveModel model in the usual way.
    #
    class Base < ActiveModel::Serializer

      def routes
        Rails.application.routes.url_helpers
      end

      def root
        false
      end

      def as_json_with_wrap(options={})
        {
          :links => links,
          :data => as_json_without_wrap
        }
      end

      def links
        {}
      end

      alias_method_chain :as_json, :wrap
    end
  end
end
