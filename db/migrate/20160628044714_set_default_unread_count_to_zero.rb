class SetDefaultUnreadCountToZero < ActiveRecord::Migration
  def change
  	change_column :users, :unread_count, :integer, :default => 0
  end
end
