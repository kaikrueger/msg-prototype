class AddDeviceIdToSensors < ActiveRecord::Migration
  def change
    add_column :sensors, :device_id, :integer
  end
end
