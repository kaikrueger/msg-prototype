class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string  :uuid
      t.string  :name
      t.integer :user_id
      t.integer :device_type_id
      t.timestamps
    end
  end
end
