require 'active_support/core_ext'
require 'erb'
require_relative 'params'
require_relative 'session'

class ControllerBase
  attr_reader :params

  def initialize(req, res, route_params)
    @req = req
    @res = res
    @params = Params.new(@req, route_params)
  end

  def session
    @session ||= Session.new(@req)
  end

  def already_rendered?
    @already_built_response
  end

  def redirect_to(url)
    @res.status = 302
    @res.header["location"] = url
    @already_built_response = true
    session.store_session(@res)
  end

  def render_content(content, type)
    @res.content_type = type
    @res.body = content
    @already_built_response = true
    session.store_session(@res)
  end

  def render(template_name)
    controller_name = self.class.to_s.underscore
    file_location = "views/#{controller_name}/#{template_name}.html.erb"
    template_file = File.read(file_location)
    erb_file = ERB.new(template_file).result(binding)
    render_content(erb_file, "text/html")
  end

  def invoke_action(name)
    self.send(name)
    render(name) unless already_rendered?
  end
end
