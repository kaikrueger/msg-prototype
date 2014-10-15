class Sensor < ActiveRecord::Base

  belongs_to :device
  validates :device_id, presence: true

  belongs_to :sensor_type_unit
  validates :sensor_type_unit_id, presence: true

  validates :uuid, presence: true, length: {maximum: 32}
  validates :name, presence: true, length: {maximum: 50}

  validates :max_value, presence: true

  def add_measurement!(timestamp, value)

    measurement_key = self.redis_measurement_key(timestamp)

    $redis.multi do
      $redis.set(measurement_key, value)
      $redis.sadd(redis_measurements_key, measurement_key)
    end
  end

  def remove_measurement!(timestamp)

    measurement_key = self.redis_measurement_key(timestamp)

    $redis.multi do
      $redis.del(measurement_key)
      $redis.srem(redis_measurements_key, measurement_key)
    end
  end

  def get_all_measurements!

    measurements = {}

    $redis.smembers(redis_measurements_key).each { |key|
      timestamp = key.split(':').last
      measurements[timestamp] = $redis.get key
    }
    measurements
  end

  def get_measurements!(from, to)

    measurements = {}

    (from..to).each { |timestamp|
      value = $redis.get redis_measurement_key(timestamp)
      if value
        measurements[timestamp] = value
      end
    }
    measurements
  end

  def redis_measurements_key
    "sensor:#{self.id}:measurements"
  end

  def redis_measurement_key(timestamp)
    "#{self.redis_measurements_key}:#{timestamp}"
  end
end