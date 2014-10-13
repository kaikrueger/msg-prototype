class CreateSensorTypeUnits < ActiveRecord::Migration
  def change
    create_table :sensor_type_units do |t|

      t.integer  "sensor_type_id"
      t.integer  "unit_id"
      t.timestamps
    end
  end
end
