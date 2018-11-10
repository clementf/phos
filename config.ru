require_relative './lib/app/phos'

Dir.glob('./lib/app/*.rb').each { |file| require file }
Dir.glob('./lib/app/{models,controllers}/*.rb').each { |file| require file }

map('/colors') { run ColorController }
map('/modes') { run ModeController }
map('/alarms') { run AlarmController }
map('/') { run WebsiteController }


