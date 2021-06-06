(select
  date_trunc('minute', readings.time) as time,
  metric_id,
  avg(readings.value) as value,
  'minute' as avg_period
from readings
group by 1, 2)
UNION ALL
(select
  date_trunc('hour', readings.time) as time,
  metric_id,
  avg(readings.value) as value,
  'hour' as avg_period
from readings
group by 1, 2)
UNION ALL
(select
  date_trunc('day', readings.time) as time,
  metric_id,
  avg(readings.value) as value,
  'day' as avg_period
from readings
group by 1, 2)