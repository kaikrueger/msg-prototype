class Device < ActiveRecord::Base

  belongs_to :user
  validates :user_id, presence: true

  belongs_to :device_type
  validates :device_type_id, presence: true

  validates :uuid, presence: true, length: {maximum: 32}
  validates :name, presence: true, length: {maximum: 50}

  has_many :sensors, dependent: :destroy


  def self.aggregate

    aggregate_type = DeviceType.find_by(name: 'Aggregate')

    Device.where(device_type_id: aggregate_type.id).each { |aggregate_device|

      Sensor.where(device_id: aggregate_device.id).each { |aggregate_sensor|

        timestamps = aggregate_sensor.get_dirty_timestamps!
        measurements = {}

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
              measurements[timestamp] = sum
            }
          }
        }

        channel = aggregate_sensor.channel_key
        WebsocketRails[channel].trigger('load', measurements)

        aggregate_sensor.clear_dirty_timestamps!
      }
    }
  end
end
