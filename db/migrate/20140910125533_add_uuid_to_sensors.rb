class AddUuidToSensors < ActiveRecord::Migration
  def change
    add_column :sensors, :uuid, :string
  end
end
