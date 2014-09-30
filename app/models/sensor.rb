class Sensor < ActiveRecord::Base

  belongs_to :user
  validates :user_id, presence: true

  validates :uuid, presence: true, length: {maximum: 32}
  validates :name, presence: true, length: {maximum: 50}

  def add_measurement!(timestamp, value)

    measurement_key = self.redis_measurement_key(timestamp)

    $redis.multi do
      $redis.set(measurement_key, value)
      $redis.sadd(redis_sensor_key, measurement_key)
    end
  end

  def remove_measurement!(timestamp)

    measurement_key = self.redis_measurement_key(timestamp)

    $redis.multi do
      $redis.del(measurement_key)
      $redis.srem(redis_sensor_key, measurement_key)
    end
  end

  def redis_sensor_key
    "sensor:#{self.id}:measurements"
  end

  def redis_measurement_key(timestamp)
    "#{self.redis_sensor_key}:#{timestamp}"
  end
end