# frozen_string_literal: true

class ColorController < Phos
  post '' do
    params = JSON.parse(@request.body.read)
    color = Color.instance.set_color(params['color'])

    message = { type: 'color', data: color.to_h }

    halt(500) unless LedStrip.send_message(message)
  end

  get '/current' do
    json Color.instance.to_h
  end
end
