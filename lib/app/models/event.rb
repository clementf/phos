# frozen_string_literal: true

class Event < ActiveRecord::Base
  validates_presence_of :name
end
