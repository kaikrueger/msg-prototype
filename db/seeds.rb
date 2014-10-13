# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

User.create(name: 'Administrator', email: 'team@mysmartgrid.de', password: '12strom', password_confirmation: '12strom', admin: true)
user = User.create(name: 'Demo User', email: 'demo@mysmartgrid.de', password: '12strom', password_confirmation: '12strom', admin: false)

device_type1 = DeviceType.create(name: 'Flukso 2')
device_type2 = DeviceType.create(name: 'RaspBerry Pi')
device_type3 = DeviceType.create(name: 'Aggregate')

device1 = Device.create(uuid: 'd1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1', name: 'Home Device', user_id: user.id, device_type_id: device_type1.id)
device2 = Device.create(uuid: 'd2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2', name: 'Farm Device', user_id: user.id, device_type_id: device_type2.id)
device3 = Device.create(uuid: 'd3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3', name: 'Office Device', user_id: user.id, device_type_id: device_type2.id)
device4 = Device.create(uuid: 'd4d4d4d4d4d4d4d4d4d4d4d4d4d4d4d4', name: 'All Devices', user_id: user.id, device_type_id: device_type3.id)

unit1 = Unit.create(symbol: 'W', name: 'Watt')
unit2 = Unit.create(symbol: 'C', name: 'Celsius')

sensor_type1 = SensorType.create(name: 'Energy Consumption')
sensor_type2 = SensorType.create(name: 'Energy Production')
sensor_type3 = SensorType.create(name: 'Temperature')

sensor_type_unit1 = SensorTypeUnit.create(sensor_type_id: sensor_type1.id, unit_id: unit1.id)
sensor_type_unit2 = SensorTypeUnit.create(sensor_type_id: sensor_type2.id, unit_id: unit1.id)
sensor_type_unit3 = SensorTypeUnit.create(sensor_type_id: sensor_type3.id, unit_id: unit2.id)

sensor1 = Sensor.create(uuid: 'd1d1d1d1d1d1d1d1s1s1s1s1s1s1s1s1', sensor_type_unit_id: sensor_type_unit1.id, name: 'First Floor', device_id: device1.id, min_value: 0, max_value: 1000)
sensor2 = Sensor.create(uuid: 'd1d1d1d1d1d1d1d1s2s2s2s2s2s2s2s2', sensor_type_unit_id: sensor_type_unit1.id, name: 'Second Floor', device_id: device1.id, min_value: 0, max_value: 1000)

sensor3 = Sensor.create(uuid: 'd2d2d2d2d2d2d2d2s1s1s1s1s1s1s1s1', sensor_type_unit_id: sensor_type_unit2.id, name: 'Roof PV Plant', device_id: device2.id, min_value: 0, max_value: 1000)
sensor4 = Sensor.create(uuid: 'd2d2d2d2d2d2d2d2s2s2s2s2s2s2s2s2', sensor_type_unit_id: sensor_type_unit2.id, name: 'Backyard PV Plant', device_id: device2.id, min_value: 0, max_value: 1000)

sensor5 = Sensor.create(uuid: 'd3d3d3d3d3d3d3d3s1s1s1s1s1s1s1s1', sensor_type_unit_id: sensor_type_unit3.id, name: 'Thermostat', device_id: device3.id, min_value: -40, max_value: 40)
sensor6 = Sensor.create(uuid: 'd3d3d3d3d3d3d3d3s2s2s2s2s2s2s2s2', sensor_type_unit_id: sensor_type_unit1.id, name: 'Equipment', device_id: device3.id, min_value: 0, max_value: 1000)

sensor7 = Sensor.create(uuid: 'd4d4d4d4d4d4d4d4s1s1s1s1s1s1s1s1', sensor_type_unit_id: sensor_type_unit1.id, name: 'Total Consumption', device_id: device4.id, min_value: 0, max_value: 10000)
sensor8 = Sensor.create(uuid: 'd4d4d4d4d4d4d4d4s2s2s2s2s2s2s2s2', sensor_type_unit_id: sensor_type_unit2.id, name: 'Total Production', device_id: device4.id, min_value: 0, max_value: 10000)


timestamp = 1400000000
minutes = 60

while minutes > 0
  timestamp = timestamp - minutes

  sensor7.add_measurement! timestamp, 1000
  sensor6.add_measurement! timestamp, 2000

  minutes = minutes - 1
end
