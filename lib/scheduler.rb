require 'clockwork'
require 'json'
require 'socket'
require 'active_support/time'
require_relative 'app/led_strip'

module Clockwork
    every(1.day, 'Wake up', :at => '07:10', tz: 'Europe/Amsterdam', :if => lambda { |t| t.wday != 6 && t.wday != 7 }) do
      message = { type: 'wake_up', data: {} }
      ::LedStrip.send_message(message)
    end
end
