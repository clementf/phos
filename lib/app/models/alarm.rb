# frozen_string_literal: true

class Alarm < ActiveRecord::Base
  serialize :days, Array
  before_save :sanitize_days

  def as_json(*)
    super.except('time', 'created_at', 'updated_at').tap do |alarm|
      alarm['hour'] = time.getlocal.strftime("%H")
      alarm['min'] = time.getlocal.strftime("%M")
    end
  end

  private

  def sanitize_days
    compact_days
    dedup_days
    sort_days
    days.select! { |day| day.between?(0, 6) }
  end

  def dedup_days
    days.uniq!
  end

  def compact_days
    days.compact!
  end

  def sort_days
    days.sort!
  end
end
