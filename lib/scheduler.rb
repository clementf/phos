# frozen_string_literal: true

require 'clockwork'
require 'json'
require 'socket'
require 'active_support/time'
require_relative 'app/phos'
require_relative 'app/led_strip'
require_relative 'app/alarm_checker'

module Clockwork
  every(1.minute, 'Wake up') do
    if AlarmChecker.new(Time.now).should_wake_up?
      message = { type: 'wake_up', data: {} }
      ::LedStrip.send_message(message)
    end
  end
end
