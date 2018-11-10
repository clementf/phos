class AlarmController < Phos
  get '' do
    json Alarm.all.order(updated_at: :desc)
  end

