class AddSensorTypeUnitIdToSensors < ActiveRecord::Migration
  def change
    add_column :sensors, :sensor_type_unit_id, :integer
  end
end
