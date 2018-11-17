# frozen_string_literal: true

require 'app/alarm_checker'
require 'spec_helper'

RSpec.describe AlarmChecker do
  let(:alarm_time_monday) { DateTime.now.monday.change(hour: 7, min: 45) }

  let(:trigger_time_monday) { alarm_time_monday.change(min: 25) }

  after do
    Alarm.destroy_all
  end

  describe '#should_wake_up?' do
    context 'on monday' do
      context 'alarms on other days' do
        before do
          Alarm.create(active: true, days: [2, 4], time: alarm_time_monday)
        end

        it 'returns false' do
          alarm_checker = AlarmChecker.new(trigger_time_monday)

          expect(alarm_checker.should_wake_up?).to eq false
        end
      end

      context 'with non active alarms' do
        before do
          Alarm.create(active: false, days: [0], time: alarm_time_monday)
        end

        it 'returns false' do
          alarm_checker = AlarmChecker.new(trigger_time_monday)

          expect(alarm_checker.should_wake_up?).to eq false
        end
      end

      context 'with active alarms' do
        before do
          Alarm.create(active: true, days: [0], time: alarm_time_monday)
        end

        it 'returns true' do
          alarm_checker = AlarmChecker.new(trigger_time_monday)

          expect(alarm_checker.should_wake_up?).to eq true
        end
      end
    end
  end
end
