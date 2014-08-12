require 'uri'
require_relative 'helpers/params_helper'
require 'debugger'

class Params
  # use your initialize to merge params from
  # 1. query string
  # 2. post body
  # 3. route params
  include ParamsHelper
  def initialize(req, route_params = {}) 
    @params = route_params
    
    parsed_query_string, parsed_post_body = {}, {}
    
    if req.query_string
      parsed_query_string = parse_www_encoded_form(req.query_string)
    end
    if req.body
      parsed_post_body = parse_www_encoded_form(req.body)
    end
    
    @params.merge!(parsed_query_string)
    @params.merge!(parsed_post_body)
  end

  def [](key)
    @params[key]
  end

  def permit(*keys)
  end

  def require(key)
  end

  def permitted?(key)
  end

  def to_s
    @params.to_s
  end

  class AttributeNotFoundError < ArgumentError; end;
end
