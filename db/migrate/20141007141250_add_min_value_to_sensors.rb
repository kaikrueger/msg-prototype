class AddMinValueToSensors < ActiveRecord::Migration
  def change
    add_column :sensors, :min_value, :float
  end
end
