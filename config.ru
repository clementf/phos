# frozen_string_literal: true

require_relative './lib/app/app'

map('/api/colors') { run ColorController }
map('/api/modes') { run ModeController }
map('/api/alarms') { run AlarmController }
map('/') { run WebsiteController }
