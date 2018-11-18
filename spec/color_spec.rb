# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Color do

  let(:color_hash) { { 'r' => 1, 'g' => 2, 'b' => 3 } }
  let(:color_black) { { 'r' => 0, 'g' => 0, 'b' => 0 } }
  let(:color_white) { { 'r' => 255, 'g' => 255, 'b' => 255 } }

  describe '#new' do
    it 'should be a singleton' do
      expect { Color.new }.to raise_error NoMethodError
    end
  end

  describe '#set_color' do
    it 'sets color from a hash' do
      color = Color.instance.set_color(color_hash)
      expect(color.red).to eq 1
      expect(color.green).to eq 2
      expect(color.blue).to eq 3
    end
  end

  describe '#-' do
    it 'substract 1 to all colors' do
      color = Color.instance.set_color(color_hash)
      color -= 1
      expect(color.red).to eq 0
      expect(color.green).to eq 1
      expect(color.blue).to eq 2
    end

    context 'when color is already black' do
      it 'does not do anything' do
        color = Color.instance.set_color(color_black)
        color -= 1
        expect(color.red).to eq 0
        expect(color.green).to eq 0
        expect(color.blue).to eq 0
      end
    end
  end

  describe '#+' do
    it 'add 1 to all colors' do
      color = Color.instance.set_color(color_hash)
      color += 1
      expect(color.red).to eq 2
      expect(color.green).to eq 3
      expect(color.blue).to eq 4
    end

    context 'when color is already white' do
      it 'does not do anything' do
        color = Color.instance.set_color(color_white)
        color += 1
        expect(color.red).to eq 255
        expect(color.green).to eq 255
        expect(color.blue).to eq 255
      end
    end
  end

  describe '#black?' do
    context 'black color' do
      it 'returns true' do
        color = Color.instance.set_color(color_black)
        expect(color.black?).to eq true
      end
    end

    context 'white color' do
      it 'returns false' do
        color = Color.instance.set_color(color_white)
        expect(color.black?).to eq false
      end
    end
  end

  describe '#max' do
    it 'returns the brighter color' do
      color = Color.instance.set_color(color_hash)
      expect(color.max).to eq 3
    end
  end

  describe '#to_s' do
    it 'shows color values' do
      color = Color.instance.set_color(color_hash)
      expect(color.to_s).to eq 'r: 1, g: 2, b: 3'
    end
  end
end
