class Sensor < ActiveRecord::Base

  belongs_to :user
  validates :user_id, presence: true

  validates :uuid, presence: true, length: {maximum: 32}
  validates :name, presence: true, length: {maximum: 50}

  def add_measurement!(timestamp, value)
    $redis.set(self.redis_key(timestamp), value)
  end

  def remove_measurement!(timestamp)
    $redis.del(self.redis_key(timestamp))
  end

  def redis_key(timestamp)
    "sensor:#{self.id}:#{timestamp}"
  end
end