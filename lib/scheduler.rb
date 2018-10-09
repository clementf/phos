require 'clockwork'
require 'json'
require 'socket'
require 'active_support/time'

module Clockwork
    every(1.day, 'Wake up', :at => '07:10', tz: 'Europe/Amsterdam', :if => lambda { |t| t.wday != 6 && t.wday != 7 }) do
      message = { type: 'wake_up', data: {} }
      s = UNIXSocket.new("/tmp/sock")
      s.send(message.to_json, 0)
    end
end
