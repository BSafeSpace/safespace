class AddLastSignOutAtToUser < ActiveRecord::Migration
  def change
    add_column :users, :last_sign_out_at, :datetime
  end
end
