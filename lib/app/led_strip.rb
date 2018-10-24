require 'singleton'
require 'sinatra/logger'

module LedStrip
  include ::SemanticLogger::Loggable

  SOCKET_PATH = '/tmp/sock'

  def self.send_message(message)
    begin
      Socket.unix(SOCKET_PATH).send(message.to_json, 0)
    rescue Errno::ECONNREFUSED, Errno::ENOENT => e
      logger.error(e.message)

      e.backtrace.each do |line|
        logger.error(line)
      end

      false
    end
  end
end
