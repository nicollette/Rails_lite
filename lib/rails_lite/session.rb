require 'json'
require 'webrick'

class Session
  def initialize(req)
    @req = req
    @cookie_value = find_cookie_value
  end

  def [](key)
    @cookie_value[key]
  end

  def []=(key, val)
    @cookie_value[key] = val
  end

  def store_session(res)
    res.cookies << WEBrick::Cookie.new("_rails_lite_app", @cookie_value.to_json)
  end
  
  def find_cookie_value
    rails_lite_cookie = @req.cookies.find do |cookie|
      cookie.name == "_rails_lite_app"
    end
    
    (rails_lite_cookie && JSON.parse(rails_lite_cookie.value)) || {}
  end
end
