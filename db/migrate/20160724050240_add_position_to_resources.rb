class AddPositionToResources < ActiveRecord::Migration[5.1]
  def change
    add_column :resources, :position, :integer
  end
end
