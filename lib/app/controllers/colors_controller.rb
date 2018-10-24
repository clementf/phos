require 'socket'

class ColorsController < Phos

  post '' do
    params = JSON.parse(@request.body.read)
    color = params['color']

    message = { type: 'color', data: color }

    halt(500) unless LedStrip.send_message(message)
  end
end
