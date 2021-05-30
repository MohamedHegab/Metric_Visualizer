class Api::V1::MetricsController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    metrics = Metric.all
    render json: MetricSerializer.new(metrics, options).serializable_hash.to_json
  end

  def show
    metric = Metric.find_by(id: params[:id])
    render json: MetricSerializer.new(metric, options).serializable_hash.to_json
  end

  def create
    metric = Metric.new(metric_params)

    if metric.save
      render json: MetricSerializer.new(metric, options).serializable_hash.to_json
    else
      render json: { error: metric.errors.messages }, status: 422
    end
  end

  def update
    metric = Metric.find_by(id: params[:id])

    if metric.update(metric_params)
      render json: MetricSerializer.new(metric, options).serializable_hash.to_json
    else
      render json: { error: metric.errors.messages }, status: 422
    end
  end

  def destroy
    metric = Metric.find_by(id: params[:id])

    if metric.destroy
      head :no_content
    else
      render json: { error: metric.errors.messages }, status: 422
    end
  end

  private

  def metric_params
    params.require(:metric).permit(:name)
  end

  def options
    @options ||= { include: %i[readings] }
  end
end
