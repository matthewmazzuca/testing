class CreateHighlights < ActiveRecord::Migration
  def change
    create_table :highlights do |t|
      t.string :name
      t.string :sub_heading
      t.binary :image
      t.references :property, index: true

      t.timestamps null: false
    end
  end
end
