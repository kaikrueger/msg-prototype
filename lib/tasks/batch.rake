namespace :batch do
  desc 'Batch Tasks'

  task aggregate: :environment do

    aggregate_type = DeviceType.find_by(name: 'Aggregate')

    Device.where(device_type_id: aggregate_type.id)
    .each { |aggregate_device|

      Sensor.where(device_id: aggregate_device.id)
      .each { |aggregate_sensor|

        timestamps = aggregate_sensor.get_dirty_timestamps!

        Device.where(user_id: aggregate_device.user_id).where.not(id: aggregate_device.id)
        .each { |device|

          Sensor.where(device_id: device.id, sensor_type_unit_id: aggregate_sensor.sensor_type_unit.id)
          .each { |sensor|

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
  end
end
