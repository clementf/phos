require_relative './lib/app/phos'

Dir.glob('./lib/app/*.rb').each { |file| require file }
Dir.glob('./lib/app/{controllers}/*.rb').each { |file| require file }

map('/colors') { run ColorsController }
map('/') { run WebsiteController }


