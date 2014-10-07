class AddUnitIdToSensors < ActiveRecord::Migration
  def change
    add_column :sensors, :unit_id, :integer
  end
end
