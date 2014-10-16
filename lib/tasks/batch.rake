namespace :batch do
  desc 'Batch Tasks'

  task aggregate: :environment do

    unit = Unit.find_by(symbol: 'W')
    aggregate_type = DeviceType.find_by(name: 'Aggregate')
    sensor_type = SensorType.find_by(name: 'Energy Consumption')
    aggregate_type_unit = SensorTypeUnit.find_by(sensor_type_id: sensor_type.id, unit_id: unit.id)
    aggregate_devices = Device.where(device_type_id: aggregate_type.id)

    aggregate_devices.each { |aggregate_device|
      aggregate_sensor = Sensor.find_by(device_id: aggregate_device.id, sensor_type_unit_id: aggregate_type_unit.id)

      if aggregate_sensor

        other_devices = Device.where(user_id: aggregate_device.user_id)
        other_devices.each { |device|

          if device != aggregate_device

            sensors = Sensor.where(device_id: device.id)
            timestamps = aggregate_sensor.get_dirty_timestamps!

            timestamps.each { |timestamp|

              sensors.each { |sensor|

                value = sensor.get_measurement! timestamp
                unless value
                  value = 0
                end

                sum = aggregate_sensor.get_measurement! timestamp
                unless sum
                  sum = 0
                end

                sum += value

                aggregate_sensor.remove_measurement! timestamp
                aggregate_sensor.add_measurement! timestamp, sum
              }
            }
          end
        }

        aggregate_sensor.clear_dirty_timestamps!
      end
    }
  end
end
