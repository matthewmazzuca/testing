class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.string :name
      t.binary :image

      t.timestamps null: false
    end
  end
end
