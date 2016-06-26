class AddBlockerIdToBlocks < ActiveRecord::Migration
  def change
    add_column :blocks, :blocker_id, :integer
  end
end
