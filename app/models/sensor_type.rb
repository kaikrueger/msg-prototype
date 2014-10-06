class SensorType < ActiveRecord::Base

  has_many :sensors

  validates :name, presence: true, length: {maximum: 20}
end
