# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(name: 'Administrator', email: 'team@mysmartgrid.de', password: '12strom', password_confirmation: '12strom', admin: true)
user = User.create(name: 'Demo User', email: 'demo@mysmartgrid.de', password: '12strom', password_confirmation: '12strom', admin: false)

device_type1 = DeviceType.create(name: 'Flukso 2')
device_type2 = DeviceType.create(name: 'RaspBerry Pi')

device = Device.create(uuid: '00000000000000000000000000000000', name: 'First Demo Device', user_id: user.id, device_type_id: device_type1.id)
Device.create(uuid: '11111111111111111111111111111111', name: 'Second Demo Device', user_id: user.id, device_type_id: device_type2.id)
Device.create(uuid: '22222222222222222222222222222222', name: 'Third Demo Device', user_id: user.id, device_type_id: device_type2.id)

Sensor.create(uuid: '00000000000000000000000000000000', name: 'First Demo Sensor', device_id: device.id)
Sensor.create(uuid: '11111111111111111111111111111111', name: 'Second Demo Sensor', device_id: device.id)
Sensor.create(uuid: '22222222222222222222222222222222', name: 'Third Demo Sensor', device_id: device.id)