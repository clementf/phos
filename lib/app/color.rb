# frozen_string_literal: true

require 'singleton'

class Color
  include Singleton

  def initialize
    color_hash = {'r' => 0, 'g' => 0, 'b' => 0}
    @red = color_hash['r']
    @green = color_hash['g']
    @blue = color_hash['b']
  end

  def set_color(color_hash)
    @red = color_hash['r']
    @green = color_hash['g']
    @blue = color_hash['b']
    self
  end

  def -(other)
    @red = [@red - other, 0].max
    @green = [@green - other, 0].max
    @blue = [@blue - other, 0].max
    self
  end

  def +(other)
    @red = [@red + other, 255].min
    @green = [@green + other, 255].min
    @blue = [@blue + other, 255].min
    self
  end

  def max
    [@red, @green, @blue].max
  end

  def black?
    @red.zero? && @green.zero? && @blue.zero?
  end

  def to_s
    "r: #{@red}, g: #{@green}, b: #{@blue}"
  end

  def to_h
    {'r' => @red, 'g' => @green, 'b' => @blue}
  end
end
