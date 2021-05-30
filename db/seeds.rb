metric1 = Metric.find_or_create_by(name: 'Metric 1')
metric2 = Metric.find_or_create_by(name: 'Metric 2')

readings = []

1.upto(10_000) do
  readings << { time: rand(3.hour.ago..Time.now), value: rand(100), metric_id: metric1.id }
  readings << { time: rand(3.hour.ago..Time.now), value: rand(100), metric_id: metric2.id }
end

Reading.insert_all(readings)
