class CreateProperties < ActiveRecord::Migration
  def change

    create_table :properties do |t|
      t.string :name
      t.string :address
      t.text :description
      t.decimal :lat, precision: 9, scale: 6
      t.decimal :lng, precision: 9, scale: 6
      t.integer :user_id
      t.timestamps
    end

    add_index :properties, :user_id
    # reversible do |dir|
    #   dir.up do
    #     execute %{
    #       create index index_on_location_coords ON properties using gist (
    #         ST_GeographyFromText(
    #           'SRID=4326;POINT(' || properties.lng || ' ' || properties.lat|| ')'
    #         )
    #       )
    #     }
    #   end

    #   dir.down do
    #     execute %{drop index index_on_location_coords}
    #   end
    # end
  end
end