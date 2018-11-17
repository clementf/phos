require_relative './lib/app/phos'

Dir.glob('./lib/app/*.rb').each { |file| require file }
Dir.glob('./lib/app/{models,controllers}/*.rb').each { |file| require file }

map('/api/colors') { run ColorController }
map('/api/modes') { run ModeController }
map('/api/alarms') { run AlarmController }
map('/') { run WebsiteController }


