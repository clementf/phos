class ColorController < Phos

  post '' do
    params = JSON.parse(@request.body.read)
    color = Color.instance.set_color(params['color'])

    message = { type: 'color', data: color.to_h }

    halt(500) unless LedStrip.send_message(message)
  end
end
