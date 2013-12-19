class Route
  attr_reader :pattern, :http_method, :controller_class, :action_name

  def initialize(pattern, http_method, controller_class, action_name)
    @pattern = pattern
    @http_method = http_method
    @controller_class = controller_class
    @action_name = action_name
  end

  def matches?(req)
    (@http_method == req.request_method.downcase.to_sym) && 
      (@pattern.match(req.path))
  end

  def run(req, res)
    route_params = {}
    
    match_data = @pattern.match(req.path)
    matched_names = match_data.names # => ["id"]
    matched_captures = match_data.captures # => ["1"]
    
    matched_names.each do |name|
      matched_captures.each do |capture|
        route_params[name.to_sym] = capture
      end
    end
    
    @controller_class.new(req, res, route_params).invoke_action(@action_name)
  end
end

class Router
  attr_reader :routes

  def initialize
    @routes = []
  end

  def add_route(route)
    @routes << route
  end

  def draw(&proc)
    self.instance_eval(&proc) 
  end

  [:get, :post, :put, :delete].each do |http_method|
    define_method(http_method) do |pattern, controller_class, action_name|
      route = Route.new(pattern, http_method, controller_class, action_name)
      add_route(route)
    end
  end

  def match(req)
    @routes.select { |route| route.matches?(req) }.first
  end

  def run(req, res)
    if match(req).nil?
      res.status = 404
    else
      match(req).run(req, res)
    end
  end
end
