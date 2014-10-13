# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

User.create(name: 'Administrator', email: 'team@mysmartgrid.de', password: '12strom', password_confirmation: '12strom', admin: true)
user = User.create(name: 'Demo User', email: 'demo@mysmartgrid.de', password: '12strom', password_confirmation: '12strom', admin: false)

device_type1 = DeviceType.create(name: 'Flukso 2')
device_type2 = DeviceType.create(name: 'RaspBerry Pi')

device1 = Device.create(uuid: '00000000000000000000000000000000', name: 'Home Device', user_id: user.id, device_type_id: device_type1.id)
device2 = Device.create(uuid: '11111111111111111111111111111111', name: 'Farm Device', user_id: user.id, device_type_id: device_type2.id)
device3 = Device.create(uuid: '22222222222222222222222222222222', name: 'Office Device', user_id: user.id, device_type_id: device_type2.id)

unit1 = Unit.create(symbol: 'W', name: 'Watt')
unit2 = Unit.create(symbol: 'C', name: 'Celsius')

sensor_type1 = SensorType.create(name: 'Energy Consumption')
sensor_type2 = SensorType.create(name: 'Energy Production')
sensor_type3 = SensorType.create(name: 'Temperature')

sensor_type_unit1 = SensorTypeUnit.create(sensor_type_id: sensor_type1.id, unit_id: unit1.id)
sensor_type_unit2 = SensorTypeUnit.create(sensor_type_id: sensor_type2.id, unit_id: unit1.id)
sensor_type_unit3 = SensorTypeUnit.create(sensor_type_id: sensor_type3.id, unit_id: unit2.id)

Sensor.create(uuid: '00000000000000000000000000000000', sensor_type_unit_id: sensor_type_unit1.id, name: 'First Floor', device_id: device1.id, min_value: 0, max_value: 1000)
Sensor.create(uuid: '11111111111111111111111111111111', sensor_type_unit_id: sensor_type_unit1.id, name: 'Second Floor', device_id: device1.id, min_value: 0, max_value: 1000)
Sensor.create(uuid: '22222222222222222222222222222222', sensor_type_unit_id: sensor_type_unit2.id, name: 'Roof PV Plant', device_id: device2.id, min_value: 0, max_value: 1000)
Sensor.create(uuid: '33333333333333333333333333333333', sensor_type_unit_id: sensor_type_unit2.id, name: 'Backyard PV Plant', device_id: device2.id, min_value: 0, max_value: 1000)
Sensor.create(uuid: '44444444444444444444444444444444', sensor_type_unit_id: sensor_type_unit3.id, name: 'Thermostat', device_id: device3.id, min_value: -40, max_value: 40)
Sensor.create(uuid: '55555555555555555555555555555555', sensor_type_unit_id: sensor_type_unit1.id, name: 'Equipment', device_id: device3.id, min_value: 0, max_value: 1000)
