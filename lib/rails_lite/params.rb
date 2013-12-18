require 'uri'

class Params
  def initialize(req, *route_params)
    @params = {}
    parse_www_encoded_form(req.query_string)
  end

  def [](key)
    @params[key]
  end

  def to_s
    @params.to_s
  end

  private
  def parse_www_encoded_form(www_encoded_form)
    decoded_array = URI.decode_www_form(www_encoded_form)
    p "DECODED ARRAY #{decoded_array}"
    decoded_array.each do |key, value|
      @params[key] = value
    end
  end

  def parse_key(key)
  end
end
