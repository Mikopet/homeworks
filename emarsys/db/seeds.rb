### Populate DB with metrics
# everything from Time.now ; 1 month = 4 weeks
#    event    |    from_min   |  to_max
# ------------+---------------+----------
# SETUP start | -2 years      | -2 months
#  STEP start | SETUP start   | -5 weeks
#    STEP end | STEP start    | -4 weeks
#   SETUP end | last STEP end | -3 weeks
#     PWD gen | STEP start    | -1 day

puts 'Deleting prev records'
Metric.delete_all

puts 'Generating SETUP and STEP starts'
id_offset = Metric.maximum(:customer_id)
1000.times do |index|
  # Create "SETUP start" for each customer
  metric = Metric.create!(
    timestamp: Faker::Time.between(from: 2.years.ago, to: 2.month.ago),
    customer_id: index + (id_offset || 0),
    admin_id: rand(1..20),
    metric_type_id: 1
  )

  # Create weighted random(1-5) count "STEP start" for current customer
  weighted_random = [0,1,2,3,4,5,5,5,5,5,5,5,5].sample
  weighted_random.times do
    Metric.create!(
      timestamp: Faker::Time.between(from: metric.timestamp, to: metric.timestamp + 3.weeks),
      customer_id: metric.customer_id,
      admin_id: rand(1..20),
      metric_type_id: 3
    )
  end
end

puts 'Generating STEP ends'
# Create (or ain't :D) "STEP end" for "STEP start"
Metric.step_start.each do |metric|
  Faker::Boolean.boolean || Metric.create!(
    timestamp: Faker::Time.between(from: metric.timestamp, to: metric.timestamp + 1.week),
    customer_id: metric.customer_id,
    admin_id: rand(1..20),
    metric_type_id: 4
  )
end

puts 'Generating SETUP ends'
# Create (or ain't) "SETUP end" for "SETUP start" where are exactly 5 "STEP end"
Metric.setup_start.each do |metric|
  last_step_ends = Metric.step_end.where(customer_id: metric.customer_id)
  next if last_step_ends.count != 5

  last_step_end_date = last_step_ends.pluck(:timestamp).max

  Faker::Boolean.boolean || Metric.create!(
    timestamp: Faker::Time.between(from: last_step_end_date, to: last_step_end_date + 2.days),
    customer_id: metric.customer_id,
    admin_id: rand(1..20),
    metric_type_id: 2
  )
end

puts 'Generating PWD gens'
# Create weighted random(0-1) count password generations for existing "STEP start"
Metric.step_start.each do |metric|
  Faker::Boolean.boolean || [0,0,0,1].sample.times do
    Metric.create!(
      timestamp: Faker::Time.between(from: metric.timestamp, to: 1.day.ago),
      customer_id: metric.customer_id,
      admin_id: rand(1..20),
      metric_type_id: 5
    )
  end
end
