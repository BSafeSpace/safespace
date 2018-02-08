class RenameUnseenCountToUnreadCount < ActiveRecord::Migration[5.1]
  def change
  	rename_column :users, :unseen_count, :unread_count
  end
end
