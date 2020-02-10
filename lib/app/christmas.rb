# frozen_string_literal: true

class Christmas < Mode
  def perform
    logger.info("start christmas mode")
    message = { type: 'christmas' }
    LedStrip.send_message(message)
  end
end
