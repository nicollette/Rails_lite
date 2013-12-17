require 'webrick'

server = WEBrick::HTTPServer.new(:Port => 8080)
trap('INT') { server.shutdown }
server.mount_proc('/') do |req, res|
  res.body = req.path
  res.content_type = 'text/text'
end

server.start