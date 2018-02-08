class AddBlockedIdToBlocks < ActiveRecord::Migration[5.1]
  def change
    add_column :blocks, :blocked_id, :integer
  end
end
