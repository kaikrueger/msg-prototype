class SensorTypeUnit < ActiveRecord::Base

  has_many :sensors

  belongs_to :sensor_type
  validates :sensor_type_id, presence: true

  belongs_to :unit
  validates :unit_id, presence: true

  def name
    "#{sensor_type.name} - #{unit.name} (#{unit.symbol})"
  end
end