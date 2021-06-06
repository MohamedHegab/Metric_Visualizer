# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_06_06_071814) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "metrics", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_metrics_on_name"
  end

  create_table "readings", force: :cascade do |t|
    t.datetime "time"
    t.integer "value"
    t.bigint "metric_id", null: false
    t.datetime "created_at", precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["metric_id"], name: "index_readings_on_metric_id"
    t.index ["time", "value"], name: "index_readings_on_time_and_value"
  end

  add_foreign_key "readings", "metrics"

  create_view "readings_averages", materialized: true, sql_definition: <<-SQL
      SELECT date_trunc('minute'::text, readings."time") AS "time",
      readings.metric_id,
      avg(readings.value) AS value,
      'minute'::text AS avg_period
     FROM readings
    GROUP BY (date_trunc('minute'::text, readings."time")), readings.metric_id
  UNION ALL
   SELECT date_trunc('hour'::text, readings."time") AS "time",
      readings.metric_id,
      avg(readings.value) AS value,
      'hour'::text AS avg_period
     FROM readings
    GROUP BY (date_trunc('hour'::text, readings."time")), readings.metric_id
  UNION ALL
   SELECT date_trunc('day'::text, readings."time") AS "time",
      readings.metric_id,
      avg(readings.value) AS value,
      'day'::text AS avg_period
     FROM readings
    GROUP BY (date_trunc('day'::text, readings."time")), readings.metric_id;
  SQL
  add_index "readings_averages", ["time", "metric_id", "avg_period"], name: "index_readings_averages_on_time_and_metric_id_and_avg_period"

end
