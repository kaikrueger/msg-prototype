class AddMaxValueToSensors < ActiveRecord::Migration
  def change
    add_column :sensors, :max_value, :float
  end
end
