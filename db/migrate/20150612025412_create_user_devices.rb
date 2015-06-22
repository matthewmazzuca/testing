class CreateUserDevices < ActiveRecord::Migration
  def change
    create_table :user_devices do |t|
      t.string :name
      t.string :token

      t.integer :user_id
      t.timestamps
    end

    add_index :user_devices, :user_id
  end
end
