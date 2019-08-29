# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Metric.destroy_all
MetricType.destroy_all

MetricType.create!([{
  id: 1,
  name: 'SETUP start'
}, {
  id: 2,
  name: 'SETUP end'
},{
  id: 3,
  name: 'STEP start'
},{
  id: 4,
  name: 'STEP end'
},{
  id: 5,
  name: 'PASSWORD regeneration'
}])

1000.times do
  Metric.create!(
    timestamp: Faker::Time.between(from: 1.year.ago, to: 1.day.ago),
    customer_id: rand(21..100),
    admin_id: rand(1..20),
    metric_type_id: rand(1..5)
  )
end
