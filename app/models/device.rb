class Device < ActiveRecord::Base

  belongs_to :user
  validates :user_id, presence: true

  belongs_to :device_type
  validates :device_type_id, presence: true

  validates :uuid, presence: true, length: {maximum: 32}
  validates :name, presence: true, length: {maximum: 50}

  has_many :sensors, dependent: :destroy


  def self.aggregate

    self.get_aggregate_devices.each { |aggregate_device|

      Sensor.where(device_id: aggregate_device.id).each { |aggregate_sensor|

        timestamps = aggregate_sensor.get_dirty_timestamps!

        Device.where(user_id: aggregate_device.user_id).where.not(id: aggregate_device.id)
        .each { |device|

          Sensor.where(device_id: device.id, sensor_type_unit_id: aggregate_sensor.sensor_type_unit.id)
          .each { |sensor|

            timestamps.each { |timestamp|

              sum = aggregate_sensor.get_measurement!(timestamp) + sensor.get_measurement!(timestamp)
              aggregate_sensor.add_measurement! timestamp, sum
            }
          }
        }
        aggregate_sensor.clear_dirty_timestamps!

        unless timestamps.empty?
          measurements = aggregate_sensor.get_measurements!(timestamps.min, timestamps.max)
          aggregate_sensor.trigger_load_event! measurements
        end
      }
    }
  end

  def self.get_aggregate_devices

    aggregate_type = DeviceType.find_by(name: 'Aggregate')
    Device.where(device_type_id: aggregate_type.id)
  end
end
