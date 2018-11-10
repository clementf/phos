class AlarmController < Phos
  get '/' do
    json Alarm.all
  end
end

