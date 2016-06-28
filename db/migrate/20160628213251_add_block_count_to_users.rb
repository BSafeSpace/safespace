class AddBlockCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :block_count, :integer, :default => 0
  end
end
