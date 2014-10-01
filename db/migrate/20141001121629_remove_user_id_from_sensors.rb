class RemoveUserIdFromSensors < ActiveRecord::Migration
  def change
    remove_column :sensors, :user_id, :integer
  end
end
