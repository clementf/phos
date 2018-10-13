require 'sinatra'
require 'socket'
require 'json'

configure { set :server, :puma }

set :bind, '0.0.0.0'
set :root, 'lib/app'

get '/' do
  render :html, :index
end

post '/colors' do
  params = JSON.parse(request.body.read)
  color = params['color']

  message = { type: 'color', data: color }
  begin
    s = UNIXSocket.new('/tmp/sock')
    s.send(message.to_json, 0)
  rescue Errno::ENOENT => e
    logger.error(e.message)

    e.backtrace.each do |line|
      logger.error(line)
    end

    halt 500
  end
end
