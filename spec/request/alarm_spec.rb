# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AlarmController do
  let(:app) { AlarmController.new }
  let(:alarm_time_monday) { DateTime.now.monday.change(hour: 7, min: 45) }

  after do
    Alarm.destroy_all
  end

  describe '#get' do
    let(:response) { get '/' }

    context 'no alarm in database' do
      it 'status is 200' do
        expect(response).to be_ok
      end

      it 'gives json' do
        expect(response.content_type).to eq 'application/json'
      end

      it 'gives an empty array' do
        alarms = JSON.parse(response.body)
        expect(alarms.size).to eq 0
      end
    end

    context 'alarms in database' do
      before do
        2.times { Alarm.create(active: true, days: [2, 4], time: alarm_time_monday) }
      end

      it 'gives two alarms back' do
        alarms = JSON.parse(response.body)
        expect(alarms.size).to eq 2
        expect(alarms.first['active']).to eq true
        expect(alarms.first['days']).to eq [2, 4]
      end
    end
  end

  describe '#post' do
    let(:post_action) { post '/', post_data, 'content_type' => 'application/json' }

    context 'good looking data' do
      let(:post_data) { { active: true, days: [0, 1], hour: 6, min: 8 }.to_json }

      it 'creates an alarm' do
        expect do
          post_action
        end.to change { Alarm.count }.from(0).to(1)
      end

      it 'gives the created alarm' do
        alarm = JSON.parse(post_action.body)
        expect(alarm['active']).to eq true
        expect(alarm['days']).to eq [0, 1]
      end
    end

    context 'data with strange days index' do
      let(:post_data) { { active: true, days: [0, 1, 8, 15, -2], hour: 6, min: 8 }.to_json }

      it 'creates an alarm' do
        expect do
          post_action
        end.to change { Alarm.count }.from(0).to(1)
      end

      it 'sanitized the days' do
        alarm = JSON.parse(post_action.body)
        expect(alarm['active']).to eq true
        expect(alarm['days']).to eq [0, 1]
      end
    end
  end

  describe '#put' do
    let(:put_action) { put "/#{Alarm.first.id}", put_data, 'content_type' => 'application/json' }

    before do
      Alarm.create(active: true, days: [2, 4], time: alarm_time_monday)
    end

    context 'good looking data' do
      let(:put_data) { { active: false, days: [0, 1], hour: 6, min: 8 }.to_json }

      it 'does not create an alarm' do
        expect do
          put_action
        end.not_to(change { Alarm.count })
      end

      it 'gives the updated alarm' do
        alarm = JSON.parse(put_action.body)
        expect(alarm['active']).to eq false
        expect(alarm['days']).to eq [0, 1]
      end
    end

    context 'data with strange days index' do
      let(:put_data) { { active: false, days: [0, 1, 8, 15, -2], hour: 6, min: 8 }.to_json }

      it 'does not create an alarm' do
        expect do
          put_action
        end.not_to(change { Alarm.count })
      end

      it 'sanitized the days' do
        alarm = JSON.parse(put_action.body)
        expect(alarm['active']).to eq false
        expect(alarm['days']).to eq [0, 1]
      end
    end
  end

  describe '#delete' do
    let(:delete_action) { delete "/#{Alarm.first.id}" }

    before do
      Alarm.create(active: true, days: [2, 4], time: alarm_time_monday)
    end

    it 'deletes the alarm' do
      expect do
        delete_action
      end.to change { Alarm.count }.from(1).to(0)
    end

    it 'status is 204' do
      expect(delete_action.status).to eq 204
    end
  end
end
