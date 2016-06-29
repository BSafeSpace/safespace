class AddPeerCounselorToUser < ActiveRecord::Migration
  def change
    add_column :users, :peer_counselor, :boolean, default: false
  end
end
