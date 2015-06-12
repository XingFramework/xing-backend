#require 'action_controller'
#require 'pp'
#pp $:
#require 'devise_token_auth'

module Xing
  class BaseController < ActionController::Base
    include DeviseTokenAuth::Concerns::SetUserByToken

    respond_to :json

    protect_from_forgery
    before_filter :check_format

    def check_format
      if request.subdomains.include? BACKEND_SUBDOMAIN
        if request.headers["Accept"] =~ /json/
          params[:format] = :json
        else
          render :nothing => true, :status => 406
        end
      end
    end

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
end
