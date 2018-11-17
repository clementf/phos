class AlarmController < Phos
  get '' do
    json Alarm.all.order(id: :desc)
  end

  post '' do
    data = HashWithIndifferentAccess.new(JSON.parse(@request.body.read))

    alarm = Alarm.create!(alarm_params(data))

    json alarm
  end

  put '/:id' do
    data = HashWithIndifferentAccess.new(JSON.parse(@request.body.read))
    alarm = Alarm.find(params[:id])
    alarm.update!(alarm_params(data))

    json alarm
  end

  delete '/:id' do
    Alarm.delete(params[:id])
  end

  private

  def alarm_params(params)
    {
      time:   Time.new(2000, 1, 1, params[:hour], params[:min], 0),
      active: params[:active],
      days:   params[:days]
    }
  end
end
