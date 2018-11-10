# frozen_string_literal: true

class Alarm < ActiveRecord::Base
  serialize :days, Array

  def as_json(*)
    super.except('time', 'created_at', 'updated_at').tap do |alarm|
      alarm['hour'] = time.hour
      alarm['min'] = time.min
    end
  end
end
