# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ColorController do
  let(:app) { ColorController.new }

  before do
    # make sure color is always reset between tests
    black_color = {'r' => 0, 'g' => 0, 'b' => 0}
    Color.instance.set_color(black_color)
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
