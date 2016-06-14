class AddAppearOfflineToUsers < ActiveRecord::Migration
  def change
    add_column :users, :appear_offline, :boolean, default: false
  end
end
