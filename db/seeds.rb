Metric.destroy_all

1000.times do |index|
  # Create "SETUP start" for each customer
  metric = Metric.create!(
    timestamp: Faker::Time.between(from: 2.years.ago, to: 3.weeks.ago),
    customer_id: index,
    admin_id: rand(1..20),
    metric_type_id: 1
  )

  # Create random(1-5) count "STEP start" for current customer
  rand(1..5).times do
    Metric.create!(
      timestamp: Faker::Time.between(from: metric.timestamp, to: 2.weeks.ago),
      customer_id: metric.customer_id,
      admin_id: rand(1..20),
      metric_type_id: 3
    )
  end
end

# Create (or ain't :D) "STEP end" for "STEP start"
Metric.step_start.each do |metric|
  Faker::Boolean.boolean || Metric.create!(
    timestamp: Faker::Time.between(from: metric.timestamp, to: 1.week.ago),
    customer_id: metric.customer_id,
    admin_id: rand(1..20),
    metric_type_id: 4
  )
end

# Create (or ain't) "SETUP end" for "SETUP start" where are exactly 5 "STEP end"
Metric.setup_start.each do |metric|
  next if Metric.step_end.where(customer_id: metric.customer_id).count != 5

  Faker::Boolean.boolean || Metric.create!(
    timestamp: Faker::Time.between(from: metric.timestamp, to: 1.day.ago),
    customer_id: metric.customer_id,
    admin_id: rand(1..20),
    metric_type_id: 2
  )
end

# Create random(0-2) count password generations for existing "STEP start"
Metric.step_start.each do |metric|
  Faker::Boolean.boolean || rand(0..2).times do
    Metric.create!(
      timestamp: Faker::Time.between(from: metric.timestamp, to: 1.day.ago),
      customer_id: metric.customer_id,
      admin_id: rand(1..20),
      metric_type_id: 5
    )
  end
end
