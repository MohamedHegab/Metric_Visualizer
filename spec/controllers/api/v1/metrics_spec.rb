require 'rails_helper'

RSpec.describe 'Api::V1::Metrics', type: :request do
  describe 'GET /index' do
    let!(:metrics) { create_list(:metric, 10) }

    before do
      get api_v1_metrics_path
    end

    it 'should return status 200' do
      expect(response.status).to eq 200
    end

    it 'should list all metrics' do
      expect(json.keys).to contain_exactly('data')
      expect(json['data'].size).to eq metrics.size
    end
  end

  describe 'GET /show' do
    let!(:metric) { create(:metric) }

    before do
      get api_v1_metric_path(metric.id)
    end

    it 'should return status 200' do
      expect(response.status).to eq 200
    end

    it 'should return metric' do
      expect(json.keys).to contain_exactly('data')
      expect(json.dig('data', 'id')).to eq metric.id.to_s
    end
  end

  describe 'POST /create' do
    context 'valid attributes' do
      let(:valid_attributes) { { metric: { name: 'metric 1' } } }

      before do
        post api_v1_metrics_path, params: valid_attributes
      end

      it 'should return status 201' do
        expect(response.status).to eq 201
      end

      it 'should create metric' do
        expect(json.keys).to contain_exactly('data')
        expect(json.dig('data', 'id')).not_to eq nil
      end
    end

    context 'invalid attributes' do
      let(:invalid_attributes) { { metric: { name: nil } } }

      before do
        post api_v1_metrics_path, params: invalid_attributes
      end

      it 'should return status 422' do
        expect(response.status).to eq 422
      end

      it 'should not create metric' do
        expect(json.keys).to contain_exactly('error')
      end
    end
  end

  describe 'PUT /update' do
    let!(:metric) { create(:metric) }

    context 'valid attributes' do
      let(:new_metric_name) { 'new metric' }
      let(:valid_attributes) { { metric: { name: new_metric_name } } }

      before do
        put api_v1_metric_path(metric.id), params: valid_attributes
      end

      it 'should return status 200' do
        expect(response.status).to eq 200
      end

      it 'should create metric' do
        expect(json.keys).to contain_exactly('data')
        expect(json.dig('data', 'attributes', 'name')).to eq new_metric_name
      end
    end

    context 'invalid attributes' do
      let(:invalid_attributes) { { metric: { name: nil } } }

      before do
        put api_v1_metric_path(metric.id), params: invalid_attributes
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
    let!(:metric) { create(:metric) }

    before do
      delete api_v1_metric_path(metric.id)
    end

    it 'should return status 204' do
      expect(response.status).to eq 204
    end

    it 'should destroy metric' do
      expect(Metric.count).to eq 0
    end
  end
end
