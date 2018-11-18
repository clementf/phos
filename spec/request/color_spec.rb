# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ColorController do
  let(:app) { ColorController.new }

  before do
    # make sure color is always reset between tests
    Color = Class.new(Color)
  end
  context 'No current color is set' do
    let(:response) { get '/current' }

    it 'status is 200' do
      expect(response).to be_ok
    end

    it 'gives json' do
      expect(response.content_type).to eq 'application/json'
    end

    it 'give default black color' do
      color = JSON.parse(response.body)
      expect(color['r']).to eq 0
      expect(color['g']).to eq 0
      expect(color['b']).to eq 0
    end
  end
end
