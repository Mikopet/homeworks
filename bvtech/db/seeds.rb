# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Sport.create!(external_id: 100, name: 'Football', active: false)
sport = Sport.create!(external_id: 240, name: 'Football', active: true)

Market.create!(sport: sport, name: 'Team A wins over Team B')

Event.create!(sport: sport, name: 'Football WC Finals 2022', due_date: Time.parse('2022-12-18 18:00'))

