# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/logger'
require 'json'

class Phos < Sinatra::Base
  logger filename: "log/#{settings.environment}.log", level: :trace

  configure { set :server, :puma }
  set :bind, '0.0.0.0'

  include ::SemanticLogger::Loggable
end
