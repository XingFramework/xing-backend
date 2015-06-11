class JsonController < ApplicationController

  respond_to :json

  def json_body
    @json_body ||= request.body.read
  end

  def parse_json
    @parsed_json ||= JSON.parse(json_body)
  end

  def failed_to_process(error_document)
    render :status => 422, :json => error_document
  end

  def successful_create(new_resource_path)
    render :status => 201, :json => {}, :location => new_resource_path
  end
end
