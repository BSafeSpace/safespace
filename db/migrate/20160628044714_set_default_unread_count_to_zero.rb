class SetDefaultUnreadCountToZero < ActiveRecord::Migration[5.1]
  def change
  	change_column :users, :unread_count, :integer, :default => 0
  end
end
