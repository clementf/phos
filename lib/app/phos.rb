# frozen_string_literal: true

require 'sucker_punch' # has to be before requiring sinatra
require 'sinatra/base'
require 'sinatra/json'
require 'sinatra/logger'
require 'json'

class Phos < Sinatra::Base
  logger filename: "log/#{settings.environment}.log", level: :trace

  configure { set :server, :puma }

  include ::SemanticLogger::Loggable
end
