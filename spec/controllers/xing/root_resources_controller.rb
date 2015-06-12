module Xing
  class RootResourcesController < ::Xing::BaseController
    def index
      @resources = rfc6570_routes(ignore: %w(format), path_only: true)
      render :json => Xing::Serializer::RootResources.new(@resources)
    end
  end
end
