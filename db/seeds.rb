# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create(name: 'Demo User', email: 'team@mysmartgrid.de', password: '12strom', password_confirmation: '12strom')

Sensor.create(uuid: '00000000000000000000000000000000', name: 'Demo Sensor', user_id: user.id)