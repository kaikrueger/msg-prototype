class Device < ActiveRecord::Base

  belongs_to :user
  validates :user_id, presence: true

  belongs_to :device_type
  validates :device_type_id, presence: true

  validates :uuid, presence: true, length: {maximum: 32}
  validates :name, presence: true, length: {maximum: 50}

  has_many :sensors, dependent: :destroy
end
