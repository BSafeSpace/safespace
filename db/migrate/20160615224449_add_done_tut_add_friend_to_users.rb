class AddDoneTutAddFriendToUsers < ActiveRecord::Migration
  def change
    add_column :users, :done_tut_add_friend, :boolean, :default => false
  end
end
