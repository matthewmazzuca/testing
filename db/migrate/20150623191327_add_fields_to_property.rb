class AddFieldsToProperty < ActiveRecord::Migration
  def change
    add_column :properties, :price, :integer
    add_column :properties, :image_url, :string
    add_column :properties, :location, :string
  end
end
