class AddBlockCountToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :block_count, :integer, :default => 0
  end
end
