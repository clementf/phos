require 'socket'

class ColorsController < Phos

  post '' do
    params = JSON.parse(@request.body.read)
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
end
