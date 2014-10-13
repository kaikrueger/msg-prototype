class RemoveUnitIdFromSensors < ActiveRecord::Migration
  def change
    remove_column :sensors, :unit_id, :integer
  end
end
