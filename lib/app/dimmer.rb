# frozen_string_literal: true

class Dimmer < Mode
  def perform(color)
    logger.info("start dimmer with color #{color}")
    total_time = 600.0
    sleep_time = total_time / color.max

    while total_time.positive? && !color.black?
      message = { type: 'color', data: color.to_h }
      LedStrip.send_message(message)
      color -= 1
      total_time -= sleep_time
      sleep(sleep_time)
    end
  end
end
