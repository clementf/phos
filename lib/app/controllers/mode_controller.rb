# frozen_string_literal: true

class ModeController < Phos
  post '' do
    params = JSON.parse(@request.body.read)
    mode = params['mode']

    if mode == 'dimmer'
      halt(500) unless Dimmer.perform_async(Color.instance)
      Event.create!(name: 'dimming')
    end
  end
end
