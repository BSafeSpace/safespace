class AddBlockedIdToBlocks < ActiveRecord::Migration
  def change
    add_column :blocks, :blocked_id, :integer
  end
end
