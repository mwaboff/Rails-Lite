require 'webrick'
server = WEBrick::HTTPServer.new(Port: 8000)

server.mount_proc "/" do |req, res|
  MyFirstController.new.go(req, res)
end

class MyFirstController < ControllerBase
  def go
    render_content("hello world!", "text/html")
    render :show
  end
end

trap('INT'){ server.shutdown }

server.start