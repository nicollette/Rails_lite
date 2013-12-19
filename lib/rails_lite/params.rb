require 'uri'

class Params
  def initialize(req, route_params)
    @params = route_params
    unless req.query_string.nil?
      @params.merge!(parse_www_encoded_form(req.query_string)) 
    end
    @params.merge!(parse_www_encoded_form(req.body)) unless req.body.nil?
  end

  def [](key)
    @params[key]
  end

  def to_s
    @params.to_s
  end

  private
  def parse_www_encoded_form(www_encoded_form)
    params = {}
    decoded_array = URI.decode_www_form(www_encoded_form)    
    decoded_array.each do |full_key, value|
      keys = parse_key(full_key)
      scope = params
      
      keys.each_with_index do |key, index|
        if index + 1 == keys.length
          scope[key] = value
        else
          scope[key] ||= {}
          scope = scope[key]
        end
      end
      
    end
    
    params
  end
  
  def parse_key(key)
    key.split(/\]\[|\[|\]/)
  end
end
