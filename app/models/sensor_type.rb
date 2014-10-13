class SensorType < ActiveRecord::Base

  has_many :sensors

  has_many :sensor_type_units

  validates :name, presence: true, length: {maximum: 20}
end
