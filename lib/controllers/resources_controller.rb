class ResourcesController < ApplicationController
  def index
    @resources = rfc6570_routes(ignore: %w(format), path_only: true)
    render :json => ResourcesSerializer.new(@resources)
  end
end
