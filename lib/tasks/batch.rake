namespace :batch do
  desc 'Batch Tasks'

  task aggregate: :environment do

    aggregate_type = DeviceType.find_by(name: 'Aggregate')

    sensor_types = SensorType.where.not(id: aggregate_type.id)
    sensor_types.each { |sensor_type|

      aggregate_type_units = SensorTypeUnit.where(sensor_type_id: aggregate_type.id)
      aggregate_type_units.each { |aggregate_type_unit|

        aggregate_devices = Device.where(device_type_id: aggregate_type.id)
        aggregate_devices.each { |aggregate_device|

          aggregate_sensors = Sensor.where(device_id: aggregate_device.id, sensor_type_unit_id: aggregate_type_unit.id)
          aggregate_sensors.each { |aggregate_sensor|

            timestamps = aggregate_sensor.get_dirty_timestamps!

            user_devices = Device.where(user_id: aggregate_device.user_id).where.not(id: aggregate_device.id)
            user_devices.each { |device|

              sensors = Sensor.where(device_id: device.id)
              sensors.each { |sensor|

                timestamps.each { |timestamp|

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
            }
            aggregate_sensor.clear_dirty_timestamps!
          }
        }
      }
    }
  end
end
