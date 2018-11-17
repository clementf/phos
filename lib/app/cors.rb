# frozen_string_literal: true

module Sinatra
  module Cors
    def self.registered(app)
      app.before do
        response.headers['Access-Control-Allow-Origin'] = '*' unless app.production?
      end

      app.options '*' do
        response.headers['Access-Control-Allow-Methods'] = 'HEAD,GET,PUT,POST,DELETE,OPTIONS'

        headers_allowed = 'X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept'
        response.headers['Access-Control-Allow-Headers'] = headers_allowed

        200
      end
    end
  end
end
