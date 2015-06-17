class CreateBeacons < ActiveRecord::Migration
  def change
    create_table :beacons do |t|
      t.string :name
      t.belongs_to :property
      t.timestamps
    end

    add_column :beacons, :uuid, :integer, array: true
    add_reference :beacons, :location, index: true
  end
end