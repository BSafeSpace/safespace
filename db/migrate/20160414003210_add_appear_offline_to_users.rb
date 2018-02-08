class AddAppearOfflineToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :appear_offline, :boolean, default: false
  end
end
