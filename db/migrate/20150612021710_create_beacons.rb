class CreateBeacons < ActiveRecord::Migration
  def change
    create_table :beacons do |t|
      t.string :name
      t.references :property, index: true
      t.timestamps
    end

    add_column :beacons, :uuid, :integer, array: true
  end
end