class Reading < ApplicationRecord
  belongs_to :metric

  validates_presence_of :time, :value
  validates_uniqueness_of :time, scope: :metric_id
  validate :time_cannot_be_in_future

  after_save :refresh_readings_average

  private

  def time_cannot_be_in_future
    errors.add(:time, 'Cannot be in future') if time&.future?
  end

  def refresh_readings_average
    ReadingsAverage.refresh
  end
end
