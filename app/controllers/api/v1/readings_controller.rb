class Api::V1::ReadingsController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :set_metric, only: :index

  def index
    return render json: { message: 'Metric not found' }, status: 422 unless @metric

    period     = params[:period] || 'minute'
    time_range = (params[:time_range] || '1_days').gsub('_', ' ')

    readings   = Reading.where(metric: @metric).send("#{period}_average_from", time_range).order('time')

    render json: ReadingSerializer.new(readings).serializable_hash.to_json
  end

  def create
    reading = Reading.new(reading_params)
    reading.metric_id = params[:metric_id]

    if reading.save
      render json: ReadingSerializer.new(reading).serializable_hash.to_json, status: :created
    else
      render json: { error: reading.errors.messages }, status: 422
    end
  end

  def destroy
    reading = Reading.find_by(id: params[:id])

    if reading.destroy
      head :no_content
    else
      render json: { error: reading.errors.messages }, status: 422
    end
  end

  private

  def set_metric
    @metric = Metric.find_by(id: params[:metric_id])
  end

  def reading_params
    params.require(:reading).permit(:time, :value)
  end
end
