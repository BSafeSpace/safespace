class AddDoneTutAddFriendToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :done_tut_add_friend, :boolean, :default => false
  end
end
