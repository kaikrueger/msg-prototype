class DeviceType < ActiveRecord::Base

  has_many :devices

  validates :name, presence: true, length: {maximum: 20}
end
