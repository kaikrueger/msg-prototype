#encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

device_type1 = DeviceType.create(name: 'device.type.flukso2')
device_type2 = DeviceType.create(name: 'device.type.raspberry_pi')
device_type3 = DeviceType.create(name: 'device.type.aggregate')

unit1 = Unit.create(symbol: 'W', name: 'Watt')
unit2 = Unit.create(symbol: '°C', name: 'Celsius')

sensor_type1 = SensorType.create(name: 'sensor.type.energy_consumption')
sensor_type2 = SensorType.create(name: 'sensor.type.energy_production')
sensor_type3 = SensorType.create(name: 'sensor.type.temperature')

sensor_type_unit1 = SensorTypeUnit.create(sensor_type_id: sensor_type1.id, unit_id: unit1.id)
sensor_type_unit2 = SensorTypeUnit.create(sensor_type_id: sensor_type2.id, unit_id: unit1.id)
sensor_type_unit3 = SensorTypeUnit.create(sensor_type_id: sensor_type3.id, unit_id: unit2.id)

User.create(name: 'Administrator', email: 'team@mysmartgrid.de', password: '12strom', password_confirmation: '12strom', admin: true)
user1 = User.create(name: 'Demo User', email: 'user@mysmartgrid.de', password: '12strom', password_confirmation: '12strom', admin: false)
user2 = User.create(name: 'Demo Benutzer', email: 'benutzer@mysmartgrid.de', password: '12strom', password_confirmation: '12strom', admin: false)

device1 = Device.create(uuid: 'd1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1', name: 'Home Device', user_id: user1.id, device_type_id: device_type1.id)
device2 = Device.create(uuid: 'd2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2', name: 'Farm Device', user_id: user1.id, device_type_id: device_type2.id)
device3 = Device.create(uuid: 'd3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3', name: 'Office Device', user_id: user1.id, device_type_id: device_type2.id)
device4 = Device.create(uuid: 'd4d4d4d4d4d4d4d4d4d4d4d4d4d4d4d4', name: 'All Devices', user_id: user1.id, device_type_id: device_type3.id)

device5 = Device.create(uuid: 'd1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1', name: 'Haus Gerät', user_id: user2.id, device_type_id: device_type1.id)
device6 = Device.create(uuid: 'd2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2', name: 'Bauernhof Gerät', user_id: user2.id, device_type_id: device_type2.id)
device7 = Device.create(uuid: 'd3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3', name: 'Büro Gerät', user_id: user2.id, device_type_id: device_type2.id)
device8 = Device.create(uuid: 'd4d4d4d4d4d4d4d4d4d4d4d4d4d4d4d4', name: 'Alle Geräte', user_id: user2.id, device_type_id: device_type3.id)

sensor1 = Sensor.create(uuid: 'd1d1d1d1d1d1d1d1s1s1s1s1s1s1s1s1', sensor_type_unit_id: sensor_type_unit1.id, name: 'First Floor', device_id: device1.id, min_value: 0, max_value: 1000)
sensor2 = Sensor.create(uuid: 'd1d1d1d1d1d1d1d1s2s2s2s2s2s2s2s2', sensor_type_unit_id: sensor_type_unit1.id, name: 'Second Floor', device_id: device1.id, min_value: 0, max_value: 1000)
sensor3 = Sensor.create(uuid: 'd2d2d2d2d2d2d2d2s1s1s1s1s1s1s1s1', sensor_type_unit_id: sensor_type_unit2.id, name: 'Roof PV Plant', device_id: device2.id, min_value: 0, max_value: 1000)
sensor4 = Sensor.create(uuid: 'd2d2d2d2d2d2d2d2s2s2s2s2s2s2s2s2', sensor_type_unit_id: sensor_type_unit2.id, name: 'Backyard PV Plant', device_id: device2.id, min_value: 0, max_value: 1000)
sensor5 = Sensor.create(uuid: 'd3d3d3d3d3d3d3d3s1s1s1s1s1s1s1s1', sensor_type_unit_id: sensor_type_unit3.id, name: 'Thermostat', device_id: device3.id, min_value: -40, max_value: 40)
sensor6 = Sensor.create(uuid: 'd3d3d3d3d3d3d3d3s2s2s2s2s2s2s2s2', sensor_type_unit_id: sensor_type_unit1.id, name: 'Equipment', device_id: device3.id, min_value: 0, max_value: 1000)

#Aggregate
Sensor.create(uuid: 'd4d4d4d4d4d4d4d4s1s1s1s1s1s1s1s1', sensor_type_unit_id: sensor_type_unit1.id, name: 'Total Consumption', device_id: device4.id, min_value: 0, max_value: 10000)
Sensor.create(uuid: 'd4d4d4d4d4d4d4d4s2s2s2s2s2s2s2s2', sensor_type_unit_id: sensor_type_unit2.id, name: 'Total Production', device_id: device4.id, min_value: 0, max_value: 10000)


sensor7 = Sensor.create(uuid: 'd5d5d5d5d5d5d5d5s1s1s1s1s1s1s1s1', sensor_type_unit_id: sensor_type_unit1.id, name: 'Erdgeschoss', device_id: device5.id, min_value: 0, max_value: 1000)
sensor8 = Sensor.create(uuid: 'd5d5d5d5d5d5d5d5s2s2s2s2s2s2s2s2', sensor_type_unit_id: sensor_type_unit1.id, name: 'Zweite Stock', device_id: device5.id, min_value: 0, max_value: 1000)
sensor9 = Sensor.create(uuid: 'd6d6d6d6d6d6d6d6s1s1s1s1s1s1s1s1', sensor_type_unit_id: sensor_type_unit2.id, name: 'Dach PV-Anlage', device_id: device6.id, min_value: 0, max_value: 1000)
sensor10 = Sensor.create(uuid: 'd6d6d6d6d6d6d6d6s2s2s2s2s2s2s2s2', sensor_type_unit_id: sensor_type_unit2.id, name: 'Hinterhof PV-Anlage', device_id: device6.id, min_value: 0, max_value: 1000)
sensor11 = Sensor.create(uuid: 'd7d7d7d7d7d7d7d7s1s1s1s1s1s1s1s1', sensor_type_unit_id: sensor_type_unit3.id, name: 'Thermostat', device_id: device7.id, min_value: -40, max_value: 40)
sensor12 = Sensor.create(uuid: 'd7d7d7d7d7d7d7d7s2s2s2s2s2s2s2s2', sensor_type_unit_id: sensor_type_unit1.id, name: 'Ausrüstung', device_id: device7.id, min_value: 0, max_value: 1000)

#Aggregate
Sensor.create(uuid: 'd8d8d8d8d8d8d8d8s1s1s1s1s1s1s1s1', sensor_type_unit_id: sensor_type_unit1.id, name: 'Gesamtverbrauch', device_id: device8.id, min_value: 0, max_value: 10000)
Sensor.create(uuid: 'd8d8d8d8d8d8d8d8s2s2s2s2s2s2s2s2', sensor_type_unit_id: sensor_type_unit2.id, name: 'Gesamterzeugung', device_id: device8.id, min_value: 0, max_value: 10000)


$redis.flushall

hour = 60 * 60
to = Time.now.to_i
from = to - hour
random = Random.new

(from..to).each { |timestamp|

  sensor1.add_measurement! timestamp, random.rand(100...300)
  sensor2.add_measurement! timestamp, random.rand(100...300)
  sensor3.add_measurement! timestamp, random.rand(100...300)
  sensor4.add_measurement! timestamp, random.rand(100...300)
  sensor5.add_measurement! timestamp, random.rand(10...40)
  sensor6.add_measurement! timestamp, random.rand(100...300)

  sensor7.add_measurement! timestamp, random.rand(100...300)
  sensor8.add_measurement! timestamp, random.rand(100...300)
  sensor9.add_measurement! timestamp, random.rand(100...300)
  sensor10.add_measurement! timestamp, random.rand(100...300)
  sensor11.add_measurement! timestamp, random.rand(10...40)
  sensor12.add_measurement! timestamp, random.rand(100...300)
}

#Device.aggregate
