require 'rails/rfc6570'

module Xing
  module Controllers
    class RootResourcesController < ::Xing::Controllers::Base
      def index
        @resources = rfc6570_routes(ignore: %w(format), path_only: true)
        render :json => Xing::Serializers::RootResources.new(@resources)
      end
    end
  end
end
