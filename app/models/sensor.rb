class Sensor < ActiveRecord::Base

  belongs_to :device
  validates :device_id, presence: true

  belongs_to :sensor_type_unit
  validates :sensor_type_unit_id, presence: true

  validates :uuid, presence: true, length: {maximum: 32}
  validates :name, presence: true, length: {maximum: 50}

  validates :max_value, presence: true

  def add_measurement!(timestamp, value)

    measurement_key = redis_measurement_key(timestamp)

    redis = get_redis_node(device.user_id)
    redis.multi do
      redis.set(measurement_key, value)
      redis.sadd(redis_measurements_key, measurement_key)
      add_dirty_timestamp!(timestamp)
    end
  end

  def get_measurement(timestamp)
    measurement_key = redis_measurement_key(timestamp)

    redis = get_redis_node(device.user_id)
    value = redis.get measurement_key
    value.to_f
  end

  def remove_measurement!(timestamp)

    measurement_key = redis_measurement_key(timestamp)

    redis = get_redis_node(device.user_id)
    redis.multi do
      redis.del(measurement_key)
      redis.srem(redis_measurements_key, measurement_key)
      self.add_dirty_timestamp!(timestamp)
    end
  end

  def get_all_measurements

    measurements = {}

    redis = get_redis_node(device.user_id)
    redis.smembers(redis_measurements_key).each { |key|
      timestamp = key.split(':').last
      measurements[timestamp] = redis.get key
    }
    measurements
  end

  def get_measurements(from, to)

    measurements = {}
    redis = get_redis_node(device.user_id)

    (from..to).each { |timestamp|
      value = redis.get redis_measurement_key(timestamp)
      if value
        measurements[timestamp] = value.to_f
      end
    }
    measurements
  end

  def trigger_load_event(measurements)
    WebsocketRails[channel_key].trigger('load', measurements)
  end

  def trigger_create_event(measurement)
    WebsocketRails[channel_key].trigger('create', measurement)
  end

  def channel_key
    "sensor:#{uuid}"
  end

  def get_dirty_timestamps

    redis = get_redis_node(device.user_id)
    timestamps = redis.smembers redis_dirty_timestamps_key
    unless timestamps
      timestamps = {}
    end
    timestamps
  end

  def add_dirty_timestamp!(timestamp)
    redis = get_redis_node(device.user_id)
    redis.sadd(redis_dirty_timestamps_key, timestamp)
  end

  def clear_dirty_timestamps!
    redis = get_redis_node(device.user_id)
    redis.del redis_dirty_timestamps_key
  end

  def redis_measurements_key
    "#{channel_key}:measurements"
  end

  def redis_measurement_key(timestamp)
    "#{redis_measurements_key}:#{timestamp}"
  end

  def redis_dirty_timestamps_key
    "sensor:#{device.user_id}:#{sensor_type_unit.sensor_type_id}:dirty:timestamps"
  end
end