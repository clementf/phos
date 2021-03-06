# frozen_string_literal: true

require 'singleton'
require 'sinatra/logger'

module LedStrip
  include ::SemanticLogger::Loggable

  SOCKET_PATH = '/tmp/sock'

  def self.send_message(message)
    logger.info("leds receiving message #{message.inspect}")
    begin
      Socket.unix(SOCKET_PATH).send(message.to_json, 0)
      true
    rescue Errno::ECONNREFUSED, Errno::ENOENT => e
      logger.error(e.message)

      e.backtrace.each do |line|
        logger.error(line)
      end

      false
    end
  end
end
