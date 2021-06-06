class ReadingsAverage < ApplicationRecord
  def self.refresh
    Scenic.database.refresh_materialized_view(table_name, concurrently: false, cascade: false)
  end

  def self.last_period(time_period)
    where('time > now() - interval ?', time_period)
  end

  private

  # This makes sure ActiveRecord wont try to save anything using this model.
  def readonly?
    true
  end
end
