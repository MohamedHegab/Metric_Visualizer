class Reading < ApplicationRecord
  belongs_to :metric

  validates_presence_of :time, :value
  validates_uniqueness_of :time, scope: :metric_id
  validate :time_cannot_be_in_future

  def self.query_average_period(metric:, period:, time_range:)
    sql = "with #{period.pluralize} as (
            select generate_series(
              date_trunc('#{period}', now()) - '#{time_range}'::interval,
              date_trunc('#{period}', now()),
              '1 #{period}'::interval
            ) as #{period}
          ) select
          #{period.pluralize}.#{period} as time,
            avg(readings.value) as value
          from #{period.pluralize}
          left join readings on date_trunc('#{period}', readings.time) = #{period.pluralize}.#{period}
          where readings.metric_id = #{metric.id}
          group by 1;"
    ActiveRecord::Base.connection.exec_query(sql)
  end

  private

  def time_cannot_be_in_future
    errors.add(:time, 'Cannot be in future') if time&.future?
  end
end
