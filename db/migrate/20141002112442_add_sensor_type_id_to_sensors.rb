class AddSensorTypeIdToSensors < ActiveRecord::Migration
  def change
    add_column :sensors, :sensor_type_id, :integer
  end
end
