class Dimmer < Mode
  def perform(color)
    logger.info("start dimmer with color #{color}")
    total_time = 600.0
    sleep_time = total_time / color.max

    while total_time > 0
      message = { type: 'color', data: color.to_h }
      LedStrip.send_message(message)
      color = color - 1
      total_time -= sleep_time
      sleep(sleep_time)
    end
  end
end
