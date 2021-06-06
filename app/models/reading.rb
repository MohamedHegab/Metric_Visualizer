class Reading < ApplicationRecord
  belongs_to :metric

  validates_presence_of :time, :value
  validates_uniqueness_of :time, scope: :metric_id
  validate :time_cannot_be_in_future

  def self.minute_average_from(time_range)
    select("date_trunc('minute', time) as time, avg(value) as value").where('time > now() - interval ?', time_range)
                                                                     .group(1)
  end

  def self.hour_average_from(time_range)
    select("date_trunc('hour', time) as time, avg(value) as value").where('time > now() - interval ?', time_range)
                                                                   .group(1)
  end

  def self.day_average_from(time_range)
    select("date_trunc('day', time) as time, avg(value) as value").where('time > now() - interval ?', time_range)
                                                                  .group(1)
  end

  private

  def time_cannot_be_in_future
    errors.add(:time, 'Cannot be in future') if time&.future?
  end
end
