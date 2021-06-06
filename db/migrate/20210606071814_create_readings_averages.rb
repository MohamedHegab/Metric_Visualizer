class CreateReadingsAverages < ActiveRecord::Migration[6.1]
  def change
    create_view :readings_averages, materialized: true
    add_index :readings_averages, %i[time metric_id avg_period]
  end
end
