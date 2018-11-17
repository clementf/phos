# frozen_string_literal: true

def prod?
  ENV['RACK_ENV'] == 'production'
end

root = Dir.getwd.to_s

puma_bind = prod? ? "unix://#{root}/tmp/puma/socket" : 'tcp://0.0.0.0:3000'
bind puma_bind
pidfile "#{root}/tmp/puma/pid"
state_path "#{root}/tmp/puma/state"
rackup "#{root}/config.ru"

threads 4, 8

activate_control_app
