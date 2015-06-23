class AddIdsToFields < ActiveRecord::Migration
  def change
    add_column :fields, :property_id, :integer
  end
end
