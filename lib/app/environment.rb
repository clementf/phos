# frozen_string_literal: true

module Sinatra
  module Environment
    def self.production?
      ENV['RACK_ENV'] == 'production'
    end
  end
end
