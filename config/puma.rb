# frozen_string_literal: true

def prod?
  ENV['RACK_ENV'] == 'production'
end

root = Dir.getwd.to_s

tmp = File.join(root, 'tmp', 'puma')
FileUtils.mkdir_p(tmp) unless File.exist?(tmp)

puma_bind = 'tcp://0.0.0.0:3000'
bind puma_bind

pidfile = File.join(tmp, 'puma')
state_path = File.join(tmp, 'state')
rackup "#{root}/config.ru"

threads 4, 8

activate_control_app
