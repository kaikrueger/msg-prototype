class Unit < ActiveRecord::Base

  has_many :sensors

  validates :symbol, presence: true, length: {maximum: 10}
  validates :name, presence: true, length: {maximum: 15}
end
