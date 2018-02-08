class AddBlockerIdToBlocks < ActiveRecord::Migration[5.1]
  def change
    add_column :blocks, :blocker_id, :integer
  end
end
