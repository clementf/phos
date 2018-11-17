# frozen_string_literal: true

require_relative './phos'

Dir.glob('./lib/app/*.rb').each { |file| require file }
Dir.glob('./lib/app/{models,controllers}/*.rb').each { |file| require file }
