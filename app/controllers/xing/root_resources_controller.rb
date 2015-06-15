require 'rails/rfc6570'

module Xing
  class RootResourcesController < ::Xing::BaseController
    def index
      @resources = rfc6570_routes(ignore: %w(format), path_only: true)
      render :json => Xing::Serializers::RootResources.new(@resources)
    end
  end
end
