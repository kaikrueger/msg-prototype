class RemoveSensorTypeIdFromSensors < ActiveRecord::Migration
  def change
    remove_column :sensors, :sensor_type_id, :integer
  end
end
