class Alarm < ActiveRecord::Base
  serialize :days, Array
end
