class DeviceType < ActiveRecord::Base

  has_many :devices

  validates :name, presence: true, length: {maximum: 40}
end
