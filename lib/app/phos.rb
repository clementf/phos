# frozen_string_literal: true

require 'sucker_punch' # has to be before requiring sinatra
require 'sinatra/base'
require 'sinatra/json'
require 'sinatra/custom_logger'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require 'json'

require_relative 'cors'
require_relative 'environment'

class Phos < Sinatra::Base
  register Sinatra::Cors
  register Sinatra::Environment

  helpers Sinatra::CustomLogger

  configure :development do
    register Sinatra::Reloader
  end

  configure :development, :production do
    logger = Logger.new(STDOUT)
    logger.level = Logger::DEBUG if development?
    set :logger, logger
  end

  configure { set :server, :puma }
end
