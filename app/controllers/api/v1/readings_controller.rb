class Api::V1::ReadingsController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    reading = Reading.new(reading_params)
    reading.metric_id = params[:metric_id]

    if reading.save
      render json: ReadingSerializer.new(reading).serializable_hash.to_json
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

  def reading_params
    params.require(:reading).permit(:time, :value)
  end
end
