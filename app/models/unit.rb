class Unit < ActiveRecord::Base

  has_many :sensor_type_units

  validates :symbol, presence: true, length: {maximum: 10}
  validates :name, presence: true, length: {maximum: 15}
end
