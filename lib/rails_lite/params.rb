require 'uri'

class Params
  def initialize(req, *route_params)
    @params = Hash.new
    parse_www_encoded_form(req.query_string) unless req.query_string.nil?
    parse_www_encoded_form(req.body) unless req.body.nil?
  end

  def [](key)
    @params[key]
  end

  def to_s
    @params.to_s
  end

  private
  def parse_www_encoded_form(www_encoded_form)
    # query_string = URI.decode_www_form("key1=val2&key2=val2")
    # => [["key1", "val2"], ["key2", "val2"]]
      #decoded request body
    # => [["cat[name]", "ernest"], ["cat[owner]", "nico"]]
   
    decoded_array = URI.decode_www_form(www_encoded_form)
    decoded_array.each do |key, value|
      if key.match(/\]\[|\[|\]/)
        main_key, nested_key = parse_key(key)
        nested_key = nested_key[0...-1]
        inner_params = { nested_key => value }
        @params[main_key] = inner_params
      else        
        @params[key] = value
      end
    end
  end
  # ## old method that parsed just the query string
  # def parse_www_encoded_form(www_encoded_form)
 #    decoded_array = URI.decode_www_form(www_encoded_form)
 #    decoded_array.each do |key, value|
 #      @params[key] = value
 #    end
 #  end


  def parse_key(key)
    main_key, nested_key = key.split("[")    
  end
end
