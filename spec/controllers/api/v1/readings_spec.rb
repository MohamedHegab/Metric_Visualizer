require 'rails_helper'

RSpec.describe 'Api::V1::Readings', type: :request do
  let(:metric) { create(:metric) }

  describe 'GET /index' do
    let(:metric_id) { metric.id }
    let!(:reading1) { create(:reading, time: 30.minutes.ago, value: 50, metric: metric) }
    let!(:reading2) { create(:reading, time: 3.hour.ago, value: 50, metric: metric) }

    before do
      get api_v1_metric_readings_path(metric_id), params: { period: period, time_range: time_range }
    end

    context 'wrong metric id' do
      let(:period) { 'minute' }
      let(:time_range) { '1_hour' }
      let(:metric_id) { 33 }

      it 'should return status 422' do
        expect(response.status).to eq 422
      end
    end

    context 'average last hour per minute' do
      let(:period) { 'minute' }
      let(:time_range) { '1_hour' }

      it 'should return status 200' do
        expect(response.status).to eq 200
      end

      it 'should get reading1 only' do
        expect(json['data'].size).to eq 1
      end

      it 'should return average for reading1' do
        expect(json.dig('data', 0, 'attributes', 'value').to_f).to eq reading1.value.to_f
      end
    end

    context 'average last month per minute' do
      let(:period) { 'minute' }
      let(:time_range) { '1_months' }

      it 'should get two readings' do
        expect(json['data'].size).to eq 2
      end
    end

    context 'average last month per day' do
      let(:period) { 'day' }
      let(:time_range) { '1_months' }

      it 'should get reading1 only' do
        expect(json['data'].size).to eq 1
      end

      it 'should return average for both readings' do
        expect(json.dig('data', 0, 'attributes', 'value').to_f).to eq([reading1.value.to_f,
                                                                       reading2.value.to_f].sum / 2)
      end
    end
  end

  describe 'POST /create' do
    context 'valid attributes' do
      let(:valid_attributes) { { reading: { time: 1.day.ago, value: 100, metric: metric } } }

      before do
        post api_v1_metric_readings_path(metric), params: valid_attributes
      end

      it 'should return status 201' do
        expect(response.status).to eq 201
      end

      it 'should create metric' do
        expect(json.keys).to contain_exactly('data')
        expect(json['data']['id']).not_to eq nil
      end
    end

    context 'invalid attributes' do
      let(:invalid_attributes) { { reading: { value: 100, metric: metric } } }

      before do
        post api_v1_metric_readings_path(metric), params: invalid_attributes
      end

      it 'should return status 422' do
        expect(response.status).to eq 422
      end

      it 'should not create metric' do
        expect(json.keys).to contain_exactly('error')
      end
    end
  end

  describe 'Destroy /destroy' do
    let!(:reading) { create(:reading, metric: metric) }

    before do
      delete api_v1_metric_reading_path(metric.id, reading.id)
    end

    it 'should return status 204' do
      expect(response.status).to eq 204
    end

    it 'should destroy metric' do
      expect(metric.readings.count).to eq 0
    end
  end
end
