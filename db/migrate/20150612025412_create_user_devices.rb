class CreateUserDevices < ActiveRecord::Migration
  def change
    create_table :user_devices do |t|
      t.string :name
      t.string :token

      t.belongs_to :user
      t.timestamps
    end
  end
end
