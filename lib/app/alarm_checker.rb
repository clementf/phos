# frozen_string_literal: true

require_relative './models/alarm'

class AlarmChecker
  ALARM_DURATION = 20.minutes

  def initialize(time, alarm_finder: Alarm)
    @time = time.utc
    @alarm_finder = alarm_finder
  end

  def should_wake_up?
    @alarm_finder.where(active: true)
                 .with_day_and_time(
                   day: (@time.wday - 1) % 6,
                   time: @time + ALARM_DURATION
                 ).present?
  end
end
